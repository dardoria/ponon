;; Original File Info:
;;
;; Repeat: Recursive Tree
;; from Form+Code in Design, Art, and Architecture 
;; by Casey Reas, Chandler McWilliams, and LUST
;; Princeton Architectural Press, 2010
;; ISBN 9781568989372
;;
;; This program is based on Context Free program 
;; "Foggy Tree by Chris Coyne:
;; http://www.contextfreeart.org/gallery/view.php?id=4 
;; 
;; This code was written for Processing 1.2+
;; Get Processing at http://www.processing.org/download
;;
;; This is a Common Lisp implementation of an example from the Book Form And Code.
;; This implementation requires ponon - https://github.com/dardoria/ponon

(in-package :formandcode-examples)

(defparameter *angle-offset-a* 1.5)
(defparameter *angle-offset-b* 50)

(defclass repeat-recursive-tree (base-app)
  ((dot-size :accessor dot-size :initform 9)))

(defmethod setup ((app repeat-recursive-tree))
  (setf *fill* nil))

(defmethod draw ((app repeat-recursive-tree))
  (set-background 1 1 1)
  (set-color 0 0 0)
  ;;(gl:translate (/ (window-width app) 2) (window-height app) 0)
  (seed1 (dot-size app) 270 0 0))


(defun seed1 (dot-size angle x y)
  (when (> dot-size 1)    
    ;; Create a random number between 0 and 1
    (let ((r (/ (random 100) 100)))
      (cond ((> r 0.02) ;;98% chance this will happen
	     (draw-circle x y dot-size)
	     (let ((newx (+ x (* (cos angle) dot-size)))
		   (newy (+ y (* (sin angle) dot-size))))
	       (seed1 (* dot-size 0.99) (- angle *angle-offset-a*) newx newy)))
	    (T ;; 2% chance this will happen
	     (draw-circle x y dot-size)
	     (let ((newx (+ x (cos angle)))
		   (newy (+ y (sin angle))))
	       (seed2 (* dot-size 0.99) (+ angle *angle-offset-a*) newx newy)
	       (seed1 (* dot-size 0.60) (+ angle *angle-offset-b*) newx newy)
	       (seed2 (* dot-size 0.50) (+ angle *angle-offset-b*) newx newy)))))))
  

(defun seed2 (dot-size angle x y)
  (when (> dot-size 1)
    (let ((r (/ (random 100) 100)))
      (cond ((> r 0.05);;95% chance this will happen
	     (draw-circle x y dot-size)
	     (let ((newx (+ x (* (cos angle) dot-size)))
		   (newy (+ y (* (sin angle) dot-size))))
	       (seed2 (* dot-size 0.99) (+ angle *angle-offset-a*) newx newy)))
	    (T ;;5% chance this will happen
	     (draw-circle x y dot-size)
	     (let ((newx (+ x (cos angle)))
		   (newy (+ y (sin angle))))
	       (seed1 (* dot-size 0.99) (+ angle *angle-offset-a*) newx newy)
	       (seed2 (* dot-size 0.60) (+ angle *angle-offset-b*) newx newy)
	       (seed1 (* dot-size 0.50) (- angle *angle-offset-b*) newx newy)))))))

(defun run-repeat-recursive-tree ()
  (run (make-app 'repeat-recursive-tree :title "repeat-resursive-tree" :width 900 :height 600)))