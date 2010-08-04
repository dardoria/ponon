(asdf:defsystem "ponon"
    :description "Common Lisp library for creative coding."
    :version "0.1"
    :author "Boian Tzonev <btzonev@gmail.com>"
    :licence "MIT License"
    :depends-on (cffi cl-glut)
    :components ((:file "package")
		 (:file "app" :depends-on ("package"))
		 (:file "window" :depends-on ("package"))
		 (:file "app-runner" :depends-on ("package"))))
		 