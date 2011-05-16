(in-package :ponon-examples)

(defclass drawing-app (base-app)())

(defmethod setup ((app drawing-app))
  (set-background 0.134 0.63 0.54))

(defmethod draw ((app drawing-app))
  (clear)
  (color 0.90 0.20 0.50)
  
  (gl:line-width 1)
  (draw-line 10 300 20 20)
  (draw-line 0 0 40 400)
  (draw-line 400 0 40 400)
  (setf *fill* T)
  (draw-rectangle 100 30 300 390)
  (setf *fill* nil)
  (color 0.90 0.76 1)
  (draw-arc 100 150 60 225 120)
  (draw-triangle 40 40 60 90 80 90)
  (setf *fill* nil)
  (draw-line 22 22 44 44)
  (color 0.90 0.920 0)
  (draw-circle 200 220 68)
  (color 0 0.920 0)
  (draw-polygon '((400 135) 
		  (215 135)
		  (365 25)
		  (305 200)
		  (250 25)))
  (draw-curve #2A((100 220 0) (50 75 0) (-40 -100 0) (300 100 0) (-4 -490 0) (80 80 0))))


(defun run-drawing-app ()
  (run (make-app 'drawing-app  :title "drawing" :pos-x 100 :pos-y 100)))