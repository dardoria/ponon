;; Original file info:
;; Parameterize: Wave
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

(defclass parametrize-waves (base-app)
  ((brick-width :accessor brick-width :initform 40)
   (brick-height :accessor brick-height :initform 15)
   (columns :accessor columns :initform 20)
   (rows :accessor rows :initform 24)
   (column-offset :accessor column-offset :initform 60)
   (row-offset :accessor row-offset :initform 30)
   (rotation-increment :accessor rotation-increment :initform 0.15)
   (bricks :accessor bricks :initform '())))

(defmethod setup ((app parametrize-waves))
  (setf *fill* nil)
  (setf (bricks app)
	(loop repeat 10 ;;(* (columns app) (rows app))
	   collect (make-rectangle 30 30 (brick-width app) (brick-height app)))))

(defmethod draw ((app parametrize-waves))
  (set-background 1 1 1)
  (set-color 0 0 0)
  (format t "start~%")
  (loop for brick in (bricks app)
     for i from 0
     do (translate brick (* i (column-offset app)) 0)
       (draw brick)))

;;   (loop for brick in (bricks app)
;;      for i from 0
;;      do (gl:with-pushed-matrix
;; 	  (gl:translate (* i (column-offset app)) 0 0)
;; 	  (draw brick))))

;;   for (int i=0; i<cols; i++) {
;;     pushMatrix();
;;     translate(i * column-offset, 0);
;;     float r = random(-QUARTER_PI, QUARTER_PI);
;;     int dir = 1;
;;     for (int j=0; j<rows; j++) {
;;       pushMatrix();
;;       translate(0, row-offset * j);
;;       rotate(r);
;;       rect(-brick-width/2, -brick-height/2, brick-width, brick-height);
;;       popMatrix();
;;       r += dir * rotationIncrement;
;;       if (r > QUARTER_PI || r < -QUARTER_PI) dir *= -1;
;;     }
;;     popMatrix();
;;   }
;; }

(defun run-parametrize-waves ()
  (run (make-app 'parametrize-waves :title "parametrize-waves" :width 1200 :height 768)))