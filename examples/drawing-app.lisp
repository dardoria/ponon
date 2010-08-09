(defpackage :ponon-drawing-example
  (:use :cl :ponon))

(in-package :ponon-drawing-example)

(defclass drawing-app (base-app)())

(defmethod setup ((app drawing-app))
  (ponon:set-background 0.134 0.63 0.54))

(defmethod draw ((app drawing-app))
  (ponon:clear)
  (gl:color 0 0 0)
  (gl:line-width 1)
  (ponon:draw-line 0.10 0 0.30 0.20)
  (ponon:draw-line 0.10 0 0.30 0))

(defun run-example ()
  (ponon:run-app (make-instance 'drawing-app) :title "drawing" :pos-x 100 :pos-y 100))