(in-package :ponon)

;; Based on code from nklein.com
;;   http://nklein.com/2009/12/rendering-text-with-cl-opengl-and-zpb-ttf

(defun draw-quad (bx1 by1 bx2 by2)
  (gl:with-primitives :triangles
    (gl:vertex bx1 by1)
    (gl:vertex bx2 by2)
    (gl:vertex bx2 by1) 
    (gl:vertex bx1 by2)))

(defun render-glyph (glyph mode cutoff)
  (zpb-ttf:do-contours (contour glyph)
    (zpb-ttf:do-contour-segments (start ctrl end) contour
      (let ((sx (zpb-ttf:x start))
	    (sy (zpb-ttf:y start))
	    (cx (when ctrl (zpb-ttf:x ctrl)))
	    (cy (when ctrl (zpb-ttf:y ctrl)))
	    (ex (zpb-ttf:x end))
	    (ey (zpb-ttf:y end)))
	(if ctrl
	    (draw-curve (make-array '(3 3) :initial-contents (list (list sx sy 0) (list cx cy 0) (list ex ey 0))))
	    (draw-line sx sy ex ey))))))

(defun render-string (string font-loader fill cutoff)
  (loop :for pos :from 0 :below (length string)
     :for cur = (zpb-ttf:find-glyph (aref string pos) font-loader)
     :for prev = nil :then cur
     :do (when prev
	   (gl:translate (- (zpb-ttf:kerning-offset prev cur font-loader)
			    (zpb-ttf:left-side-bearing cur))
			 0 0))
	 (render-glyph cur (if fill :polygon :line-strip) cutoff)
         (gl:translate (zpb-ttf:advance-width cur) 0 0)))

(defun calculate-cutoff (font-loader size)
  (gl:with-pushed-matrix
    (let ((ss (/ size (zpb-ttf:units/em font-loader))))
      (gl:scale ss ss ss)

      (let ((modelview (gl:get-double :modelview-matrix))
	    (projection (gl:get-double :projection-matrix))
	    (viewport (gl:get-integer :viewport)))
	(labels ((dist (x1 y1 z1 x2 y2 z2)
		   (max (abs (- x1 x2))
			(abs (- y1 y2))
			(abs (- z1 z2))))
		 (dist-to-point-from-origin (px py pz ox oy oz)
		   (multiple-value-bind (nx ny nz)
		       (glu:un-project px py pz
				       :modelview modelview
				       :projection projection
				       :viewport viewport)
		     (dist nx ny nz ox oy oz))))
	  (multiple-value-bind (ox oy oz)
	      (glu:un-project 0.0 0.0 0.0
			      :modelview modelview
			      :projection projection
			      :viewport viewport)
	    (/ (min (dist-to-point-from-origin 1 0 0 ox oy oz)
		    (dist-to-point-from-origin 0 1 0 ox oy oz))
	       2)))))))

(defun draw-string (font-loader string x y &key (size 48) (filled t)
		                            (cutoff nil))
  (unless cutoff
    (setf cutoff (calculate-cutoff font-loader size)))

  (gl:with-pushed-matrix
    (let* ((box (zpb-ttf:string-bounding-box string font-loader :kerning t))
	   (bx1 (aref box 0))
	   (by1 (aref box 1))
	   (bx2 (aref box 2))
	   (by2 (aref box 3)))

      (let ((ss (/ size (zpb-ttf:units/em font-loader))))
	(gl:scale ss (* ss -1) ss)) ;;flip the y axis, as the cooordinate system's center is at top left corner

      (gl:translate x y 0.0)
      
      (gl:with-pushed-attrib (:current-bit :color-buffer-bit :line-bit
				           :hint-bit :stencil-buffer-bit)
	;; antialias lines
	(gl:enable :blend)
	(gl:blend-func :src-alpha :one-minus-src-alpha)
	(gl:enable :line-smooth)
	(gl:hint :line-smooth-hint :nicest)
	(gl:with-pushed-matrix
	    (render-string string font-loader nil cutoff))

	(when filled
	  ;; fill stencil buffer with filled-in-glyph
	  (gl:color-mask nil nil nil nil)
	  (gl:enable :stencil-test)
	  (gl:stencil-mask 1)
	  (gl:clear-stencil 0)
	  (gl:clear :stencil-buffer-bit)
	  (gl:stencil-func :always 1 1)
	  (gl:stencil-op :invert :invert :invert)
	  (gl:with-pushed-matrix
	      (render-string string font-loader t cutoff))

	  ;; fill in area subject to stencil
	  (gl:color-mask t t t t)
	  (gl:stencil-func :equal 1 1)
	  (draw-quad bx1 by1 bx2 by2)))))
  cutoff)
