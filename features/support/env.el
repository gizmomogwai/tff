(require 'f)

(defvar tff-support-path
  (f-dirname load-file-name))

(defvar tff-features-path
  (f-parent tff-support-path))

(defvar tff-root-path
  (f-parent tff-features-path))

(add-to-list 'load-path tff-root-path)

;; Ensure that we don't load old byte-compiled versions
(let ((load-prefer-newer t))
  (require 'tff)
  (require 'espuds)
  (require 'ert))

(Setup
 ;; Before anything has run
 )

(Before
 ;; Before each scenario is run
 )

(After
 ;; After each scenario is run
 )

(Teardown
 ;; After when everything has been run
 )
