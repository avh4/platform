Given /^an input document "([^\"]*)"$/ do |doc|
  @input_document = doc
end

When /^I ask to see a formatted view of my document$/ do
  @current_view = "testbed/#{@input_document}.html"
  FileUtils.rm_rf "testbed"
  FileUtils.mkdir_p "testbed"
  File.should_not exist @current_view
  
  Platform.process_document "test_data/input/#{@input_document}", @current_view
  
  File.should exist @current_view
end

class Platform
  def self.process_document(input, output)
    require 'maruku'
    engine = Maruku.new(File.read(input))
    File.open(output, 'w') do |f|
      f.write(File.read("steps/header.txt"))
      f.write(engine.to_html)
      f.write(File.read("steps/footer.txt"))
    end
  end
end

Then /^I should see a formatted view of "([^\"]*)"$/ do |doc|
  @current_view.should look_like "test_data/output/#{doc}.html"
end

def look_like(expected)
  LookLike.new(expected)
end

class LookLike
  def initialize(expected)
    @expected = expected
  end
  def matches?(target)
    @target = target
    expected_contents = File.read(@expected)
    target_contents = File.read(@target)
    
    expected_contents == target_contents
  end
  def failure_message
    diff = `diff -u '#{@expected}' '#{@target}'`
    "Expected the contents of '#{@expected}', but the contents of '#{@target}' differ:\n#{diff}"
  end
end