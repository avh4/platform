TESTBED_DIR = File.join(File.dirname(__FILE__), "..", "testbed")

Before do
  FileUtils.rm_rf TESTBED_DIR
  FileUtils.mkdir_p TESTBED_DIR
  Dir.chdir TESTBED_DIR
end

Given /^an input document "([^\"]*)"$/ do |doc|
  @input_document = doc
  FileUtils.cp "../test_data/input/#{@input_document}", "./"
end

When /^I ask to see a formatted view of my document$/ do
  @current_view = "#{@input_document}.html"
  File.should_not exist @current_view
  
  Platform.process_documents
  File.should exist @current_view
end

Then /^I should see a formatted view of "([^\"]*)"$/ do |doc|
  @current_view.should look_like "../test_data/output/#{doc}.html"
end
