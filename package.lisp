(in-package #:cl-user)

(defpackage :ponon
  (:use :cl :cl-glut)
  (:shadow #:get #:close #:special)
  (:export
   ;;window
   #:glut-window
   ;;app
   #:base-app
   #:setup
   #:update
   #:draw
   #:exit
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
   ;;app-runner
   #:app-runner
   #:run
   #:window-position-x
   #:window-position-y
   #:window-width
   #:window-height
   #:screen-width
   #:screen-height
   #:set-window-postion
   #:set-wndow-size
   #:set-fullscreen))