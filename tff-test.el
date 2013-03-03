(require 'tff)

(expectations
  (defun h-file() "/home/gizmo/_projects/blub/src/module.h")
  (defun cpp-file() "/home/gizmo/_projects/blub/src/module.cpp")
  (defun test-file() "/home/gizmo/_projects/blub/test/module_test.cpp")

  (defun h-file-pattern() "\\(.*?\\)\\.h")
  (defun h-file-replacement() "\\1.cpp")

  (defun cpp-file-pattern() "\\(.*?\\)src\\(.*?\\)\\.cpp")
  (defun cpp-file-replacement() "\\1test\\2_test.cpp")

  (defun test-file-pattern() "\\(.*?\\)test\\(.*?\\)_test.cpp")
  (defun test-file-replacement() "\\1src\\2.h")

  (desc "transform from .h to .cpp")
  (expect (cpp-file) (tff/replace (h-file) (h-file-pattern) (h-file-replacement)))

  (desc "transform from .cpp to _test.cpp")
  (expect (test-file) (tff/replace (cpp-file) (cpp-file-pattern) (cpp-file-replacement)))

  (desc "transform from _test.cpp to .h")
  (expect (h-file) (tff/replace (test-file) (test-file-pattern) (test-file-replacement)))

  (desc "dont transform if pattern does not match")
  (expect "test" (tff/replace "test" "\\(.*?\\)\\.h" "test2"))

  (desc "replace does not fail with empty list")
  (expect "1" (tff/replace-with-first-match "1" '()))

  (desc "replace with the first in the list")
  (expect "1" (tff/replace-with-first-match "test" '(("test" "1") ("abc" "2"))))

  (desc "replace with the second in the list")
  (expect "2" (tff/replace-with-first-match "test" '(("abc" "1") ("test" "2"))))

  (setq roundtrip '())

  (setq h-stuff '())
  (add-to-list 'h-stuff (h-file-pattern) t)
  (add-to-list 'h-stuff (h-file-replacement) t)
  (add-to-list 'roundtrip h-stuff t)

  (setq cpp-stuff '())
  (add-to-list 'cpp-stuff (cpp-file-pattern) t)
  (add-to-list 'cpp-stuff (cpp-file-replacement) t)
  (add-to-list 'roundtrip cpp-stuff t)

  (setq test-stuff '())
  (add-to-list 'test-stuff (test-file-pattern) t)
  (add-to-list 'test-stuff (test-file-replacement) t)
  (add-to-list 'roundtrip test-stuff t)

  (desc "roundtrip from .h to .cpp")
  (expect (cpp-file) (tff/replace-with-first-match (h-file) roundtrip))

  (desc "roundtrip from .cpp to _test.cpp")
  (expect (test-file) (tff/replace-with-first-match (cpp-file) roundtrip))

  (desc "roundtrip from _test.cpp to .h")
  (expect (h-file) (tff/replace-with-first-match (test-file) roundtrip))
)

