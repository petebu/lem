(in-package :lem-core)

(setf deploy:*macos-info-plist-template*
      (asdf:system-relative-pathname "lem" "resources/Info.plist.in"))

(setf deploy:*macos-app-icon*
      (asdf:system-relative-pathname "lem" "resources/Lem.icns"))

(add-hook *after-init-hook*
          (lambda ()
            ;; PATH injection for macOS
            (setf (uiop:getenv "PATH")
                  (format nil "~{~A~^:~}" (exec-path)))
            ;; Prevent the startup directory from becoming root
            (when (deploy:deployed-p)
              (let ((dir (user-homedir-pathname)))
                (setq *default-pathname-defaults* dir)
                (uiop:chdir dir)))))
