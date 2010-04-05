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