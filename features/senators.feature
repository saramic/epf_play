Feature: Senators
  Scenario: List of all current senators
    Given I have a source
    When I run the senator importer
    And I visit senator list
    Then I should see the senators