(defpackage :ponon-drawing-example
  (:use :cl :ponon))

(in-package :ponon-drawing-example)

(defclass drawing-app (base-app)())

(defmethod setup ((app drawing-app))
  (ponon:set-background 120 230 60))

(defmethod draw ((app drawing-app))
  (ponon:clear)
  (glut:swap-buffers))

(defun run-example ()
  (ponon:run-app (make-instance 'drawing-app) :title "drawing" :pos-x 100 :pos-y 100))