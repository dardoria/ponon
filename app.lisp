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
  
