;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; app-runner.lisp --- Ponon app runner
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

;;TODO make this work with generic windows
(defclass app-runner ()
  ((app :accessor app)
   (window :accessor window)))

(defgeneric run (app-runner app glut-window))
(defmethod run ((runner app-runner) (app base-app) (window glut-window))
  (setf (app runner) app)
  (setf (app window) app)
  (setf (window runner) window)
  (setf (app-runner app) runner)
;;todo handle errors and close window
  (glut:display-window window)
  (run-via-infinite-loop window app))

(defgeneric window-position-x (app-runner))
(defmethod window-position-x ((runner app-runner))
  (pos-x (window runner)))

(defgeneric window-position-y (app-runner))
(defmethod window-position-y ((runner app-runner))
  (pos-y (window runner)))

(defgeneric window-width (app-runner))
(defmethod window-width ((runner app-runner))
  (width (window runner)))

(defgeneric window-height (app-runner))
(defmethod window-height ((runner app-runner))
  (height (window runner)))

(defgeneric screen-width (app-runer))
(defgeneric screen-height (app-runner))

(defgeneric set-window-position (app-runner integer integer))
(defmethod set-window-position ((runner app-runner) x y)
  (setf (pos-x (window runner)) x)
  (setf (pos-y (window runner)) y))
  
(defgeneric set-window-size (app-runner integer integer))
(defmethod set-window-size ((runner app-runner) width height)
  (setf (width (window runner)) width)
  (setf (height (window runner)) height))

;;TODO a generic function with this name is already defined elsewhere
;; (defgeneric set-window-title (app-runner string))
;; (defmethod set-window-title ((runner app-runner) title)
;;   (setf (title (window runner)) title))

(defgeneric set-fullscreen (app-runner boolean))

;;main run function
;;TODO use rest args
(defun run-app (app)
  (let ((window (make-instance 'ponon:glut-window))
	(runner (make-instance 'ponon:app-runner)))
    (run runner app window)))