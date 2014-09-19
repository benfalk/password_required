Feature: Deleting a object that is password protected

  Scenario:
    Given there is a widget named "test widget"
    And I am on the "test widget" show page
    When I click the "Delete Widget" button
    Then I should find a "password_request[password]" field
    And put "password" in the "password_request[password]" field
    And click the "continue" button
    Then I should not have one widget named "test widget"
