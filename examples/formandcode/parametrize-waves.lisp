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
   (rotation-increment :accessor rotation-increment :initform 0.15)))

(defmethod setup ((app parametrize-waves))
  (setf *fill* nil))

(defmethod draw ((app parametrize-waves))
  (ponon::with-state
    (translate 30 30 0)

    (set-background 1 1 1)
    (set-color 0 0 0)

    (dotimes (i (columns app))
      (ponon::with-state
	(translate (* i (column-offset app)) 0 0)
	(let ((r (ponon::random-range -45 45))
	      (dir 1))
	  (dotimes (j (rows app))
	    (ponon::with-state
	      (translate 0 (* j (row-offset app)) 0)
	      (rotate r 0 0 1)
	      (draw-rectangle (- (/ (brick-width app) 2)) (- (/ (brick-height app) 2)) (brick-width app) (brick-height app)))
	    (incf r (* dir (rotation-increment app)))
	    (when (or (> r 45)
		      (< r -45))
	      (setf dir -1))))))))

(defun run-parametrize-waves ()
  (run (make-app 'parametrize-waves :title "parametrize-waves" :width 1200 :height 768)))