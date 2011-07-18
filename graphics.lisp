;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; graphics.lisp --- Ponon graphics interface
;;;
;;; Copyright (c) 2010, Boian Tzonev <boiantz@gmail.com>
;;;
;;; Permission is hereby granted, free of charge, to any person obtaining a copy
;;; of this software and associated documentation files (the "Software"), to deal
;;; in the Software without restriction, including without limitation the rights
;;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;;; copies of the Software, and to permit persons to whom the Software is
;;; furnished to do so, subject to the following conditions:
;;;
;;; The above copyright notice and this permission notice shall be included in
;;; all copies or substantial portions of the Software.
;;;
;;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;;; THE SOFTWARE.

(in-package :ponon)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defmacro with-fill-mode (mode &body body)
    `(let ((new-mode (if *fill* ,mode :line-loop)))
       (gl:with-primitives new-mode ,@body))))

(defparameter *bg-color* `(0 0 0))
(defparameter *fill* nil)

(defun set-background (red green blue)
  (setf *bg-color* (list red green blue))
  (clear))

(defun set-color (red green blue &optional (alpha 0))
  (gl:color red green blue alpha))

(defun clear ()
  (gl:clear-color (first *bg-color*) (second *bg-color*) (third *bg-color*) 0)
  (gl:clear :color-buffer :depth-buffer))
 
(defun draw-line (x1 y1 x2 y2)
  (gl:with-primitives :lines
    (gl:vertex x1 y1)
    (gl:vertex x2 y2)))

(defun draw-rectangle (x y width height)
  (if *fill*
      (gl:rect x y (+ x width)(+ y height))
      (gl:with-primitives :line-loop
	(gl:vertex x y)
	(gl:vertex (+ x width) y)
	(gl:vertex (+ x width) (+ y height))
	(gl:vertex x (+ y height)))))
  
(defun draw-triangle (x1 y1 x2 y2 x3 y3)
  (with-fill-mode :triangles
    (gl:vertex x1 y1)
    (gl:vertex x2 y2)
    (gl:vertex x3 y3)))

(defun draw-circle (x y radius)
  ;;algorithm adapted from http://slabode.exofire.net/circle_draw.shtml
  (with-fill-mode :triangle-fan
    (let* ((circle-points (* 10 (sqrt radius)))
	   (theta (/ (* 2 pi) circle-points))
	   (c (cos theta))
	   (s (sin theta))
	   (tmp-x radius)
	   (tmp-y 0)
	   (tmp nil))
      (loop repeat circle-points
	 do (progn
	      (gl:vertex (+ x tmp-x) (+ y tmp-y))
	      (setf tmp tmp-x)
	      (setf tmp-x (- (* c tmp-x) (* s tmp-y)))
	      (setf tmp-y (+ (* s tmp) (* c tmp-y))))))))

;;quadric
(defvar *quadric* nil)

(defun draw-arc (x y radius start-angle arc-angle)
  ;;todo if start angle is greater than arc angle rotate them
  (unless *quadric*
    (setf *quadric* (glu:new-quadric)))
  (glu:quadric-draw-style *quadric* :silhouette) ;;boundary only
  (glu:quadric-normals *quadric* :none)
  (gl:with-pushed-matrix
    (gl:translate x y 0.0)
    (glu:partial-disk *quadric* radius radius 20 4 start-angle arc-angle)))


;;tessellator
(defvar *tessellator* nil)

(defclass ponon-tessellator (glu:tessellator)
  ())

(defmethod glu:vertex-data-callback ((tess ponon-tessellator) vertex-data polygon-data)
  (gl:vertex (first vertex-data) (second vertex-data) (third vertex-data)))

(defmethod glu:combine-data-callback ((tess ponon-tessellator) coords vertex-data weight polygon-data)
  (loop for i from 0 below 3
     collect (gl:glaref coords i)))

(defun draw-polygon (points)
  (unless *tessellator*
    (setf *tessellator* (make-instance 'ponon-tessellator)))
  ;;todo this should save and restore the previous value
  ;;todo this should be able to draw not solid polygons too
  (glu:tess-property *tessellator* :winding-rule :positive)

  (glu:with-tess-polygon (*tessellator* nil)
    (glu:with-tess-contour *tessellator*
      (loop for coords in points
	 do (glu:tess-vertex *tessellator* coords coords)))))

(defun draw-curve (points)
  ;;todo this could be a one-time operation 
  (gl:shade-model :flat)
  (gl:map1 :map1-vertex-3 0 1 points)
  (gl:enable :map1-vertex-3)

  (gl:with-primitive :line-strip 
    (loop for i from 0 to 30 ;;todo no magick numbers
       do (gl:eval-coord-1 (/ i 30)))))