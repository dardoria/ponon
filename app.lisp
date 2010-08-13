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

(defclass base-app ()
  ((app-runner :accessor app-runner)))

(defgeneric setup (base-app))
(defmethod setup ((app base-app)))

(defgeneric update (base-app))
(defmethod update ((app base-app)))

(defgeneric draw (base-app))
(defmethod draw ((app base-app)))

(defgeneric exit (base-app))
(defmethod exit ((app base-app)))

(defgeneric window-resized (base-app width height)
  (:documentation "Handle window resized event."))

(defmethod window-resized ((app base-app) width height)
  (gl:viewport 0 0 width height)
  (gl:matrix-mode :projection)
  (gl:load-identity)
  (glu:ortho-2d 0 width 0 height))

(defgeneric key-pressed (base-app key)
  (:documentation "Handle key pressed event."))
(defmethod key-pressed ((app base-app) key))

(defgeneric key-released (base-app key)
  (:documentation "Handle key released event"))
(defmethod key-released ((app base-app) key))

(defgeneric special-key-pressed (base-app key)
  (:documentation "Handle special (function) key pressed event."))
(defmethod special-key-pressed ((app base-app) key))

(defgeneric special-key-released (base-app key)
  (:documentation "Handle special (function) key released  event."))
(defmethod special-key-released ((app base-app) key))

(defgeneric mouse-moved (base-app x y)
  (:documentation "Handle mouse moved to x and y position event."))
(defmethod mouse-moved ((app base-app) x y))

(defgeneric mouse-dragged (base-app x y )
  (:documentation "Handle mouse dragged to x and y position event."))
(defmethod mouse-dragged ((app base-app) x y))

(defgeneric mouse-pressed (base-app x y button)
  (:documentation "Handle mouse button pressed at x and y position event."))
(defmethod mouse-pressed ((app base-app) x y button))

(defgeneric mouse-released (base-app x y button)
  (:documentation "Handle mouse button released at x and y position"))
(defmethod mouse-released ((app base-app) x y button))

(defgeneric audio-received (base-app stream buffer-size channels-nbr)
  (:documentation "Handle audio received at input stream with buffer-size and number of channels event."))
(defmethod audio-received ((app base-app) stream buffer-size channels-nbr))

(defgeneric audio-requested (base-app stream buffer-size channels-nbr)
  (:documentation "Handle audio requested at otput stream with buffer-size and number of channels event."))
(defmethod audio-requested ((app base-app) stream buffer-size channels-nbr)) 