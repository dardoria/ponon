;; Original file info:
;; Repeat: Embedded Iteration 
;; from Form+Code in Design, Art, and Architecture 
;; by Casey Reas, Chandler McWilliams, and LUST
;; Princeton Architectural Press, 2010
;; ISBN 9781568989372
;; 
;; This code was written for Processing 1.2+
;; Get Processing at http://www.processing.org/download
;;
;; This is a Common Lisp implementation of an example from the Book Form And Code.
;; This implementation requires ponon - https://github.com/dardoria/ponon

(in-package :formandcode-examples)

(defclass repeat-embedded (base-app)
  ((option :accessor option :initform 1)))

(defmethod setup ((app repeat-embedded))
  (setf *fill* nil))

(defmethod draw ((app repeat-embedded))
  (set-background 0 0 0)
  
  (loop for x by 20 from 50 below (- (window-width app) 50)
     do (loop for y by 20 upto 50 below (- (window-height app) 50)
	   do (case (option app) 
		(1 ;; Option 1: Stitches 
		 (draw-line (- x 5) (- y 5) (+ x 5) (+ y 5))
		 (draw-line (+ 5 x) (- y 5) (- x 5) (+ 5 y)))
		(2 ;; Option 2: Perspective
		 (draw-line x y (/ (window-width app) 2) (/ (window-height app) 2)))
		(3 ;; Option 3: Overlapping circles 
		 (draw-circle x y 40))
		(4 ;; Option 4: Rotating arcs 
		 (draw-arc x y 14 y (+ x PI)))		 
		(5 ;;Option 5: Groups of five  
		 (loop for i from 0 by 4 below 16
		    do (draw-line (+ x i) y (+ x i) (+ y 12)))
		 (draw-line x y (+ x 12) (+ y 12)))))))

(defmethod mouse-pressed ((app repeat-embedded) x y button)
  (incf (option app))
  (when (> (option app) 5)
    (setf (option app) 1)))

(defun run-repeat-embedded ()
  (run (make-app 'repeat-embedded :title "repeat-embedded" :width 400 :height 300)))