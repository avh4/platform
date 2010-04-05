Feature: Writing a document
  In order to organize and publish my thoughts
  As a document author
  I want see a nicely formatted version of my document

  Scenario: Writing a document
    Given an input document "Writing a document.markdown"
    When I ask to see a formatted view of my document
    Then I should see a formatted view of "Writing a document.markdown"
  
  Scenario: Writing a document with a different name
    Given an input document "Writing a document with a different name.markdown"
    When I ask to see a formatted view of my document
    Then I should see a formatted view of "Writing a document with a different name.markdown"
  
