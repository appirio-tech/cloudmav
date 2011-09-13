Feature: Contact CodeMav

  As a visitor
  I want to contact CodeMav
  So that I can ask a question

  Scenario: Contact CodeMav

    Given I am a visitor
    When I contact CodeMav
    Then CodeMav should receive a contact email
