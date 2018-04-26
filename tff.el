;;; tff.el --- Toggles between corresponding files.

;; Author: Christian Köstlin <christian.koestlin@gmail.com>
;; Keywords: tools
;; Package-Requires: ((emacs "24.4"))
;; Package-Version: 0.1.0
;; Homepage: http://github.com/gizmomogwai/org-kanban

;;; Commentary:
(require 'cl-lib)

;;; Code:

(defgroup tff nil
  "Toggle between Friend Files."
  :group 'tff)

(defcustom tff/patterns-and-replacements
  '(
    ("\\(.*?\\)\\.h" "\\1.cpp")
    ("\\(.*?\\)src\\(.*?\\)\\.cpp" "\\1test\\2_test.cpp")
    ("\\(.*?\\)test\\(.*?\\)_test.cpp" "\\1src\\2.h")
    )
  "Regexp patterns to try against buffernames with associated replacements."
  :type '(repeat
	  (list
	   (regexp :tag "regexp")
	   (string :tag "replacement")))
  :group 'tff)

(defun tff/replace
  (pattern input newstring)
  "Replace the PATTERN in INPUT with NEWSTRING.  NEWSTRING may reference regex groups with \1."
  (let* (
         (found (string-match pattern input))
         (res (if (eq found nil) input (replace-match newstring nil nil input)))
         )
    res))

(defun tff/replace-with-first-match
  (input patterns-and-replacements)
  "Replace the INPUT by applying `tff/replace' to all entries in PATTERNS-AND-REPLACEMENTS."
  (if (car patterns-and-replacements)
      (let* (
             (pattern-and-replacement (car patterns-and-replacements))
             (todo (cdr patterns-and-replacements))
             (replaced (tff/replace (car pattern-and-replacement) input (car (cdr pattern-and-replacement))))
             (finished (not (string= input replaced)))
             )
        (if finished replaced (tff/replace-with-first-match input todo)))
    input))

(defun tff
  ()
  "Toggle between friend files (see tff customization group)."
  (interactive)
  (let* ((file-name (buffer-file-name))
	 (new-file-name (tff/replace-with-first-match file-name tff/patterns-and-replacements)))
    (if (not (string= file-name new-file-name)) (find-file new-file-name))))

(progn
  (put 'tff/patterns-and-replacements 'safe-local-variable 'listp))

(provide 'tff)
;;; tff.el ends here
