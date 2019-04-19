Feature: json and xml file upload

  As a calcentral developer
  So that I can see overlapping fields for models
  I want to upload json and xml files corresponding to each model and see their contents.

 Scenario: Uploading a valid json file with data for 3 new models
   Given I visit the file upload page
   When I upload a json file
   Then I should see "was successfully created."
   And I should be sent to the products index page

  Scenario: Not uploading a file
   Given I visit the file upload page
   When I don't upload a file
   Then I should see "Please attach a valid file"
   And I should see the file upload page again

   Scenario: Uploading a valid xml file with data for 3 new models
     Given I visit the file upload page
     When I upload a xml file
     Then I should see "was successfully created."
     And I should be sent to the products index page



   Scenario: Uploading an invalid file that is not json or xml
     Given I visit the file upload page
     When I upload an invalid file
     Then I should see "Incompatible file type, please attach a valid file"
     And I should see the file upload page again
