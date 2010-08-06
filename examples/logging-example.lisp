(defpackage :ponon-logging-example
  (:use :cl :ponon))

(in-package :ponon-logging-example)

(defclass logging-app (base-app)())

(defmethod setup ((app logging-app))
  (format t "~a~%" "setup logging app"))

(defmethod update ((app logging-app)))

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

