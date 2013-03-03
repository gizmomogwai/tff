(require 'cl)

(defgroup tff nil
  "Toggle between Friend Files."
  :group 'tff)

(defcustom tff/patterns-and-replacements
  '(
    ("\\(.*?\\)\\.h" "\\1.cpp")
    ("\\(.*?\\)src\\(.*?\\)\\.cpp" "\\1test\\2_test.cpp")
    ("\\(.*?\\)test\\(.*?\\)_test.cpp" "\\1src\\2.h")
    )
  "regexp patterns to try against buffernames with associated replacements"
  :type '(repeat
	  (list
	   (regexp :tag "regexp")
	   (string :tag "replacement")))
  :group 'tff)

(defun tff/replace
  (input pattern newstring)
  "replaces input with newstring if the pattern matches. newstring may reference regex groups with \1"
  (let* (
         (found (string-match pattern input))
         (res (if (eq found nil) input (replace-match newstring nil nil input)))
         )
    res)
  )

(defun tff/replace-with-first-match
  (input patterns-and-replacements)
  "replaces the input by applying tff/replace to all entries in patterns-and-replacements"
  (if (first patterns-and-replacements)
      (let* (
             (pattern-and-replacement (first patterns-and-replacements))
             (todo (rest patterns-and-replacements))
             (replaced (tff/replace input (first pattern-and-replacement) (second pattern-and-replacement)))
             (finished (not (string= input replaced)))
             )
        (if finished replaced (tff/replace-with-first-match input todo)))
    input))

(defun tff
  ()
  "toggles between friend files (see tff customization group)"
  (interactive)
  (let* ((file-name (buffer-file-name))
	 (new-file-name (tff/replace-with-first-match file-name tff/patterns-and-replacements)))
    (if (not (string= file-name new-file-name)) (find-file new-file-name))))

(progn
  (put 'tff/patterns-and-replacements 'safe-local-variable 'listp)
)

(provide 'tff)
