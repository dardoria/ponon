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

(defgeneric update (base-app))

(defgeneric draw (base-app))

(defgeneric exit (base-app))

(defgeneric window-resized (base-app integer integer)
  (:documentation "Window resized with new width and height"))

(defgeneric key-pressed (base-app integer)
  (:documentation "Parameter is key-code"))

(defgeneric key-released (base-app integer)
  (:documentation "Parameter is key-code"))

(defgeneric special-key-pressed (base-app integer)
  (:documentation "Parameter is key-code"))

(defgeneric special-key-released (base-app integer)
  (:documentation "Parameter is key-code"))

(defgeneric mouse-moved (base-app integer integer)
  (:documentation "Mouse moved to x and y position"))

(defgeneric mouse-dragged (base-app integer integer)
  (:documentation "Mouse dragged to x and y position"))

(defgeneric mouse-pressed (base-app integer integer integer)
  (:documentation "Mouse pressed at x and y position with button"))

(defgeneric mouse-released (base-app integer integer integer)
  (:documentation "Mouse released at x and y position with button"))

(defgeneric audio-received (base-app stream integer integer)
  (:documentation "Audio received at input stream with buffer-size and number of channels"))

(defgeneric audio-requested (base-app stream integer integer)
  (:documentation "Audio requested at otput stream with buffer-size and number of channels"))