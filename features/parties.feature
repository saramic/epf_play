Feature: process parties from 2010 source

  Scenario: pull parties out of source and display on webpage
    Given that the 2010 senate group voting ticket source is loaded
    When I process the source
    And I visit the parties page
    Then I should see the following parties
      | Socialist Alliance |
      | The Greens         |

