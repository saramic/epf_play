Feature: Show a ballot with preferences and reduce it according to preference vote

  Scenario: load data and show first preferences
    Given that the aec results data is loaded
    And the aec results are processed
    When I visit the ballot page
    And I select 2010 Federal Election
    And I select VIC
    Then I should see first preferences

    When I press reduce
    Then the group ticket votes get distributed

    When I press reduce
    Then the lowest voted senator is eliminated
    And the votes get distributed

    When I press reduce to the end
    Then the reduce cycle continues till only senators with an electable quota are left
    And the elected senators are
      | name and id |
