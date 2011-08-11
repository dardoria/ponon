;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; app.lisp --- Ponon base app
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

(defmacro make-app (app-class &rest window-args)
  `(let* ((app (make-instance (find-class ,app-class)))
          (app-window (make-instance 'ponon:glut-window ,@window-args)))
     (setf (window app) app-window)
     (setf (app app-window) app)
     app))

(defclass base-app ()
  ((window :accessor window)
   (fps :accessor frames-per-second :initform 25)))

(defgeneric run (app)
  (:documentation "Start display loop")
  (:method ((app base-app))
    (glut:display-window (window app))))

(defgeneric setup (base-app))
(defmethod setup ((app base-app)))

(defgeneric update (base-app))
(defmethod update ((app base-app)))

(defgeneric draw (base-app))
(defmethod draw ((app base-app)))

(defgeneric exit (base-app))
(defmethod exit ((app base-app))
  (setf (app-running app) nil))

(defgeneric window-position-x (app)
  (:method ((app base-app))
    (pos-x (window app))))

(defgeneric window-position-y (app)
  (:method ((app base-app))
    (pos-y (window app))))

(defgeneric window-width (app)
  (:method ((app base-app))
    (width (window app))))

(defgeneric window-height (app)
  (:method ((app base-app))
    (height (window app))))

(defgeneric screen-width (app))
(defgeneric screen-height (app))

(defgeneric set-window-position (app integer integer)
  (:method ((app base-app) x y)
    (setf (pos-x (window app)) x)
    (setf (pos-y (window app)) y)))
  
(defgeneric set-window-size (app integer integer)
  (:method ((app base-app) width height)
    (setf (width (window app)) width)
    (setf (height (window app)) height)))

;;TODO a generic function with this name is already defined elsewhere
;; (defgeneric set-window-title (app-runner string))
;; (defmethod set-window-title ((runner app-runner) title)
;;   (setf (title (window runner)) title))

(defgeneric set-fullscreen (app boolean))

(defgeneric window-resized (base-app width height)
  (:documentation "Handle window resized event.")
  ;;todo resize window correctly
  (:method ((app base-app) width height)
     (gl:viewport 0 0 width height)
     (gl:matrix-mode :projection)
     (gl:load-identity)
     (if (<= width height)
         (glu:ortho-2d 0 width 0 height)
         (glu:ortho-2d width 0 height 0))
     (gl:matrix-mode :modelview)
     (gl:load-identity)))

(defgeneric key-pressed (base-app key)
  (:documentation "Handle key pressed event.")
  (:method ((app base-app) key)))

(defgeneric key-released (base-app key)
  (:documentation "Handle key released event")
  (:method ((app base-app) key)))

(defgeneric special-key-pressed (base-app key)
  (:documentation "Handle special (function) key pressed event.")
  (:method ((app base-app) key)))

(defgeneric special-key-released (base-app key)
  (:documentation "Handle special (function) key released  event.")
  (:method ((app base-app) key)))

(defgeneric mouse-moved (base-app x y)
  (:documentation "Handle mouse moved to x and y position event.")
  (:method ((app base-app) x y)))

(defgeneric mouse-dragged (base-app x y )
  (:documentation "Handle mouse dragged to x and y position event.")
  (:method ((app base-app) x y)))

(defgeneric mouse-pressed (base-app x y button)
  (:documentation "Handle mouse button pressed at x and y position event.")
  (:method ((app base-app) x y button)))

(defgeneric mouse-released (base-app x y button)
  (:documentation "Handle mouse button released at x and y position")
  (:method ((app base-app) x y button)))

(defgeneric audio-received (base-app stream buffer-size channels-nbr)
  (:documentation "Handle audio received at input stream with buffer-size and number of channels event.")
  (:method ((app base-app) stream buffer-size channels-nbr)))

(defgeneric audio-requested (base-app stream buffer-size channels-nbr)
  (:documentation "Handle audio requested at otput stream with buffer-size and number of channels event.")
  (:method ((app base-app) stream buffer-size channels-nbr)))