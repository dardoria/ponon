;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; loggin-example.lisp --- A simple app that logs the invocation of every app method
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

(defpackage :ponon-logging-example
  (:use :cl :ponon))

(in-package :ponon-logging-example)

(defclass logging-app (base-app)())

(defmethod setup ((app logging-app))
  (format t "~a~%" "setup logging app"))

(defmethod update ((app logging-app))
  (format t "~a~%" "update logging app"))

(defmethod draw ((app logging-app))
  (format t "~a~%" "draw logging app"))

(defmethod window-resized ((app logging-app) width height)
  (format t "~a~%" "rezise window logging app"))

(defmethod key-pressed ((app logging-app) key)
  (format t "~a~%" "key-presed logging app"))

(defmethod key-released ((app logging-app) key)
  (format t "~a~%" "key-released logging app"))

(defmethod special-key-pressed ((app logging-app) key)
  (format t "~a~%" "special-key-presed logging app"))

(defmethod special-key-released ((app logging-app) integer)
  (format t "~a~%" "special-key-presed logging app"))

(defmethod mouse-moved ((app logging-app) x y)
  (format t "~a~%" "mouse moved logging app"))

(defmethod mouse-dragged ((app logging-app) x y)
  (format t "~a~%" "moue dragged logging app"))

(defmethod mouse-pressed ((app logging-app) x y button)
  (format t "~a~%" "muse pressed logging app"))

(defmethod mouse-released ((app logging-app) x y button)
  (format t "~a~%" "mouse released logging app"))


(defun run-example ()
  (ponon:run-app (make-instance 'logging-app)))

