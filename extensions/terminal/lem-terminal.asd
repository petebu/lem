(defsystem "lem-terminal"
  :defsystem-depends-on ("cffi-toolchain")
  :depends-on ("lem/core")
  :serial t
  :components ((:c-file "terminal-c" :pathname "terminal" :pkg-config "vterm" :lib-name "terminal")
               (:file "ffi")
               (:file "terminal")
               (:file "terminal-mode")))
