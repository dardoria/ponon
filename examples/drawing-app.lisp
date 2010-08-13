(in-package :ponon-examples)

(defclass drawing-app (base-app)())

(defmethod setup ((app drawing-app))
  (ponon:set-background 0.134 0.63 0.54))

(defmethod draw ((app drawing-app))
  (ponon:clear)
  (ponon:color 0.90 0.20 0.50)
  (gl:line-width 1)
  (ponon:draw-line 10 300 20 20)
  (ponon:draw-line 0 0 40 400)
  (ponon:draw-line 400 0 40 400)
  (setf ponon:*fill* T)
  (ponon:draw-rectangle 100 30 300 390)
  (setf ponon:*fill* nil)
  (ponon:color 0.90 0.20 0)
  (ponon:draw-triangle 40 40 60 90 80 90)
  (setf ponon:*fill* t)
  (ponon:draw-triangle 40 40 60 90 80 90)))

(defun run-example ()
  (ponon:run-app (make-instance 'drawing-app) :title "drawing" :pos-x 100 :pos-y 100))