;; This file contains your project specific step definitions. All
;; files in this directory whose names end with "-steps.el" will be
;; loaded automatically by Ecukes.

(Given "^I am in buffer \"\\(.+\\)\"$"
  (lambda (arg)
    (find-file arg)
    ))

(When "^I have \"\\(.+\\)\"$"
  (lambda (something)
    ;; ...
    ))

(Then "^I should have \"\\(.+\\)\"$"
  (lambda (something)
    ;; ...
    ))

(And "^I have \"\\(.+\\)\"$"
  (lambda (something)
    ;; ...
    ))

(But "^I should not have \"\\(.+\\)\"$"
  (lambda (something)
    ;; ...
    ))

(And "^I run \\(.+\\)$"
     (lambda (function)
       (funcall (intern function))
       ))

(Then "^I should be in buffer \"\\([^\"]+\\)\"$"
      (lambda (arg)
        (should (string= arg (buffer-name)))
    ))
