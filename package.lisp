;;; -*- Mode: Lisp; indent-tabs-mode: nil -*-
;;;
;;; package.lisp --- Ponon package definition and exports
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

(in-package #:cl-user)

(defpackage :ponon
  (:use :cl :cl-glut)
  (:shadow #:get #:close #:special)
  (:export
   ;;window
   #:glut-window
   ;;app
   #:make-app
   #:base-app
   #:setup
   #:update
   #:draw
   #:exit
   #:run
   #:window-position-x
   #:window-position-y
   #:window-width
   #:window-height
   #:screen-width
   #:screen-height
   #:set-window-postion
   #:set-wndow-size
   #:set-fullscreen
   #:window-resized
   #:key-pressed
   #:key-released
   #:special-key-pressed
   #:special-key-released
   #:mouse-moved
   #:mouse-dragged
   #:mouse-pressed
   #:mouse-released
   #:audio-received
   #:audio-requested
   ;;graphics
   #:*fill*
   #:set-background
   #:clear
   #:set-color
   #:draw-line
   #:draw-rectangle
   #:draw-triangle
   #:draw-circle
   #:draw-arc
   #:draw-polygon
   #:draw-curve))