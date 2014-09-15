Feature: Posting to a password protected action

  @wip
  Scenario: Attempting to create a resource
    When I visit the "new_widget_path"
    And put "My Widget" in "widget[name]" field
    And click the "Create Widget" button
    Then I should find a "password_request[password]" field
    And put "password" in the "password_request[password]" field
    And click the "continue" button
    Then I should have one widget named "My Widget"

