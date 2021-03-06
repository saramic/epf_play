Feature: Sources
  In order to store, process, track, version and show full transparency of data sources
  As a curator/admin/editor/name?
  I should be able to
  create a source
  download the relevant asset html/pdf/csv/img
  re-download to check if it has changed
  version it if it has changed

  Scenario: Create a source
    Given that the URL for the source exists
      | http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos | Senator_photos.html |
    And I exist as a user
    And I am logged in
  #    And I am a curator # TODO authorisation
    When I go to create a new source
    And I create the source
      | description | I am not sure of the source nor url |
    Then source create will fail with "Source not created. Please review the messages below"

    When I go to create a new source
    And I create the source
      | title       | All current senators                                                |
      | url         | http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos |
      | description | Full senator list maybe -1 for president.                           |
    Then the source will be created successfully
    And the url will be downloaded and stored

    When I go back to list sources
    Then I should see the source

    When I edit the source
    And I update the source
      | description | Full senator list maybe -1 for president. May be useful to show who will stay on. |
    Then the source will be updated successfully

    When I update the source
      | url | http://some.different.url/ |
    Then the source will be updated successfully
    And the update will not take place
      | url | http://some.different.url/ |

# TODO fetch asset, maybe in a background task

# TODO duplicate - later create version
#    When I go to create a new source
#    And I create the source
#      | url         | http://www.aph.gov.au/Senators_and_Members/Senators/Senators_photos |
#    Then the source will not be created with error "dupliacate url" or "url exists, new version will be created if it is different"

# TODO url and/or title mandatory
#    When I go to create a new source
#    And I create the source
#      | description | Full senator list maybe -1 for president.                           |

# TODO generate title from url if none is supplied

# TODO only allow edit of meta data, title/description not url/asset
