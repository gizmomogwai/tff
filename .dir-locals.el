(
  (nil . ; all modes
    (
      (tff/patterns-and-replacements . ; our variable
        (
          ; pairs of regexps and replacements
          ; replacements can reference groups
          ("\\(.*\\)_test\\.cpp" "\\1.hpp") ; converts module_test.cpp -> module.hpp
          ("\\(.*\\)\\.hpp" "\\1.cpp") ; converts module.hpp -> module.cpp
          ("\\(.*\\)\\.cpp" "\\1_test.cpp") ; converts module.cpp -> module_test.cpp
        )
      )
    )
  )
)
