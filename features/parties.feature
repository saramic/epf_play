Feature: process parties from 2010 source

  Scenario: pull parties out of source and display on webpage
    Given that the 2010 senate group voting ticket source is loaded
    """
2010 Federal Election Senate Group Voting Tickets [Event:15508 Phase:FinalResults Generated:2013-01-22T15:02:59 Cycle:109e02bb-5f15-4808-984f-b47255b191fb Created:2013-01-22T14:55:43 Environment:PROD Site:PARKES Server:NTR01 Version:6.0.10.10009]
State,OwnerGroupID,OwnerGroupNm,OwnerTicket,TicketNo,CandidateID,CandidateTicket,Surname,GivenNm,BallotPosition,PartyAb,PartyNm,PreferenceNo
NSW,1,Party 1,,,21446,,EVANS,Rachel
VIC,1,Party 1,,,21449,,ISKANDER,Soubhi
ACT,1,Party 2,,,22023,,HODGES,Robert
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

