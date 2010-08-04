(defpackage :ponon-logging-example
  (:use :cl :ponon))

(in-package :ponon-logging-example)

(defclass logging-app (base-app)())

(defmethod setup ((app logging-app))
  (format t "~a~%" "setup logging app"))

(defmethod update ((app logging-app))
  (format t "~a~%" "update logging app"))

(defmethod draw ((app logging-app))
  (format t "~a~%" "draw logging app"))

(defun run-example ()
  (let ((window (make-instance 'ponon:glut-window :width 300 :height 300))
	(runner (make-instance 'ponon:app-runner))
	(app (make-instance 'logging-app)))
    (ponon:run runner app window)))

