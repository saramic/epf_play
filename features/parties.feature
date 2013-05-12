Feature: process parties from 2010 source

  Scenario: pull parties out of source and display on webpage
    Given that the 2010 senate group voting ticket source is loaded
    """
2010 Federal Election Senate Group Voting Tickets [Event:15508 Phase:FinalResults Generated:2013-01-22T15:02:59 Cycle:109e02bb-5f15-4808-984f-b47255b191fb Created:2013-01-22T14:55:43 Environment:PROD Site:PARKES Server:NTR01 Version:6.0.10.10009]
State,OwnerGroupID,OwnerGroupNm,OwnerTicket,TicketNo,CandidateID,CandidateTicket,Surname,GivenNm,BallotPosition,PartyAb,PartyNm,PreferenceNo
NSW,1,Party 4,,,21446,,EVANS,Rachel,,PT1,Party 1,
VIC,1,Party 4,,,21449,,ISKANDER,Soubhi,,PT1,Party 1,
ACT,1,Party 5,,,22023,,HODGES,Robert,,PT2,Party 2,
    """
    When I process the source
    And I visit the parties page
    Then I should see the following parties
      | Party 1 |
      | Party 2 |

    When I visit the candidates page
    Then I should see the following candidates
      | Rachel EVANS    |
      | Soubhi ISKANDER |
      | Robert HODGES   |

    When I visit the homepage
    And navigate by state "NSW"
    Then I should see the party "Party 1"
    Then I should not see the party "Party 2"

    When I navigate by party "Party 1"
    Then I should see the candidate "Rachel EVANS"
    And I should not see the candidate "Soubhi ISKANDER"
    And I should not see the candidate "Robert HODGES"

  Scenario: edit existing parties to add relevant information
    Given that the 2010 senate group voting ticket source is loaded and processed
    And I exist as an admin user
    When I visit the parties page
    Then I should not be allowed to edit a party

    When I am logged in
    And I visit the parties page
    Then I should be allowed to edit a party

    When I update the party
    Then I should see a party edited message
