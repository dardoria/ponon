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

(defgeneric window-resized (base-app integer integer)
  (:documentation "Window resized with new width and height"))
(defmethod window-resized ((app base-app) width heigth))

(defgeneric key-pressed (base-app integer)
  (:documentation "Parameter is key-code"))
(defmethod key-pressed ((app base-app) key))

(defgeneric key-released (base-app integer)
  (:documentation "Parameter is key-code"))
(defmethod key-released ((app base-app) key))

(defgeneric special-key-pressed (base-app integer)
  (:documentation "Parameter is key-code"))
(defmethod special-key-pressed ((app base-app) key))

(defgeneric special-key-released (base-app integer)
  (:documentation "Parameter is key-code"))
(defmethod special-key-released ((app base-app) key))

(defgeneric mouse-moved (base-app integer integer)
  (:documentation "Mouse moved to x and y position"))
(defmethod mouse-moved ((app base-app) x y))

(defgeneric mouse-dragged (base-app integer integer)
  (:documentation "Mouse dragged to x and y position"))
(defmethod mouse-dragged ((app base-app) x y))

(defgeneric mouse-pressed (base-app integer integer integer)
  (:documentation "Mouse pressed at x and y position with button"))
(defmethod mouse-pressed ((app base-app) x y button))

(defgeneric mouse-released (base-app integer integer integer)
  (:documentation "Mouse released at x and y position with button"))
(defmethod mouse-released ((app base-app) x y button))

(defgeneric audio-received (base-app stream integer integer)
  (:documentation "Audio received at input stream with buffer-size and number of channels"))
(defmethod audio-received ((app base-app) stream buffer-size channels-nbr))

(defgeneric audio-requested (base-app stream integer integer)
  (:documentation "Audio requested at otput stream with buffer-size and number of channels"))
(defmethod audio-requested ((app base-app) stream buffe-size channels-nbr)) 