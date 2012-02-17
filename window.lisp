;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; window.lisp --- Ponon base window
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

(defclass glut-window (glut:window)
  ((app :accessor app))
  (:default-initargs :width 500 :height 500 :title "ponon" :mode '(:rgb :double :depth :alpha)))

(defmethod glut:display-window :before ((window glut-window))
  (setup (app window))
  (update (app window)))

(defmethod glut:keyboard ((window glut-window) key x y)
  (declare (ignore x y))
  (key-pressed (app window) key)
  (case key
    (#\Esc 
     (glut:destroy-current-window))))

(defmethod glut:keyboard-up ((window glut-window) key x y)
  (declare (ignore x y))
  (key-released (app window) key))

(defmethod glut:special ((window glut-window) special-key x y)
  (declare (ignore x y))
  (special-key-pressed (app window) special-key))

(defmethod glut:special-up ((window glut-window) special-key x y)
  (declare (ignore x y))
  (special-key-released (app window) special-key))

(defmethod glut:mouse ((window glut-window) button state x y)
  (cond ((eq state :down)
	 (mouse-pressed (app window) button x y))
	((eq state :up)
	 (mouse-released (app window) button x y))))

(defmethod glut:motion ((window glut-window) x y)
  (mouse-dragged (app window) x y))

(defmethod glut:passive-motion ((window glut-window) x y)
  (mouse-moved (app window) x y ))

(defmethod glut:reshape ((window glut-window) width height)
  (window-resized (app window) width height))

(defmethod glut:display ((window glut-window))  
  (draw (app window))
  (glut:swap-buffers))

(defmethod glut:close ((window glut-window))
  (exit (app window)))

;; (defparameter my-time 0)
;; (defparameter my-timebase 0)
;; (defparameter my-frame 0)
;; (defparameter my-fps 0)

(defmethod glut:idle ((window glut-window))

;;   (incf my-frame)
;;   (setf my-time (glut:get :elapsed-time))
;;   (when (> (- my-time my-timebase) 1000)
;;     (progn
;;       (setf my-fps (/ (* my-frame 1000) (- my-time my-timebase)))
;;       (setf my-timebase my-time)
;;       (setf my-frame 0)
;;       (format t "~$~%" my-fps)))
  
  (let* ((app (app window))
         (skip-ticks (/ 1000 (frames-per-second app))) ;;todo define this once
         (next-tick (get-internal-real-time))
         (sleep-time 0))
    
    (incf next-tick skip-ticks)
    (setf sleep-time (/ (- next-tick (get-internal-real-time)) 1000))
    
    (when (> sleep-time 0)
      (sleep sleep-time))

  (update (app window))
  (glut:post-redisplay)))
    



