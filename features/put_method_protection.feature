Feature: Editing an object that is password protected

  Scenario:
    Given there is a widget named "test widget"
    When I am on the "test widget" edit page
    And put "My Widget" in "widget[name]" field
    And click the "Update Widget" button
    Then I should find a "password_request[password]" field
    And put "password" in the "password_request[password]" field
    And click the "continue" button
    Then I should have one widget named "My Widget"
