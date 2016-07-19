@logged-in
Feature: Listing permitted roles on resources

  Background:
    Given a resource

  Scenario: Initial permitted roles is just the owner, and the roles which have the owner.
    When I list the roles who can "fry" it
    Then the JSON should be:
    """
    [
      "cucumber:user:admin",
      "cucumber:user:alice"
    ]
    """

  Scenario: An additional user with the specified privilege is included in the list
    Given a new user "bob"
    And I permit user "bob" to "fry" it
    When I list the roles who can "fry" it
    Then the JSON should be:
    """
    [
      "cucumber:user:admin",
      "cucumber:user:alice",
      "cucumber:user:bob"
    ]
    """

  Scenario: An additional user with an unrelated privilege is not included in the list
    Given a new user "bob"
    And I permit user "bob" to "freeze" it
    When I list the roles who can "fry" it
    Then the JSON should be:
    """
    [
      "cucumber:user:admin",
      "cucumber:user:alice"
    ]
    """

  Scenario: An additional owner role is included in the list
    Given a new user "bob"
    And I grant my role to user "bob"
    When I list the roles who can "fry" it
    Then the JSON should be:
    """
    [
      "cucumber:user:admin",
      "cucumber:user:alice",
      "cucumber:user:bob"
    ]
    """