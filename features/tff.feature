Feature: Toggle between files
  Scenario: Switch from test.hpp -> test.cpp
    Given I am in buffer "test.hpp"
    And I run tff
    Then I should be in buffer "test.cpp"
  Scenario: Switch from test.cpp -> test_test.cpp
    Given I am in buffer "test.cpp"
    And I run tff
    Then I should be in buffer "test_test.cpp"
  Scenario: Switch from test_test.cpp -> test.hpp
    Given I am in buffer "test_test.cpp"
    And I run tff
    Then I should be in buffer "test.hpp"
