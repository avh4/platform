Before do
  FileUtils.rm_rf "testbed"
  FileUtils.mkdir_p "testbed"
end

Given /^an input document "([^\"]*)"$/ do |doc|
  @input_document = doc
end

When /^I ask to see a formatted view of my document$/ do
  @current_view = "testbed/#{@input_document}.html"
  File.should_not exist @current_view
  
  Platform.process_document "test_data/input/#{@input_document}", @current_view
  File.should exist @current_view
end

Then /^I should see a formatted view of "([^\"]*)"$/ do |doc|
  @current_view.should look_like "test_data/output/#{doc}.html"
end
