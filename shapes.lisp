;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; shapes.lisp --- Ponon shapes
;;;
;;; Copyright (c) 2011, Boian Tzonev <boiantz@gmail.com>
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

(defclass shape ())

(defgeneric rotate (shape x y z))
(defgeneric move (shape x y z))
(defgeneric scale (shape))
(defgeneric draw (shape))

;;rectangle
(defclass rectangle (shape)
  (x :accessor x :initform 0 :initarg :x)
  (y :accessor y :initform 0 :initarg :y)
  (width :accessor width :initform 0 :initarg :width)
  (height :accessor height :initform 0 :initarg :height))

(defmethod draw ((rect rectangle))
  (draw-rectangle (x rect) (y rect) (width rect) (height rect)))

(defun make-rectangle (x y width height)
  (make-instance 'rectangle :x x :y y :width width :height height))

(defclass triangle (shape))
(defclass circle (shape))
(defclass arc (shape))
(defclass polygon (shape))
(defclass curve (shape))