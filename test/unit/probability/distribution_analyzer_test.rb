
require 'test/test_helper'

class DistributionAnalyzerTest < Test::Unit::TestCase

  context "given an analyzer" do
    setup do
      @analyzer = DistributionAnalyzer.new
    end
    context "given an object that provides a collection of 4 uniform class probabilities" do
      setup do
        @distribution.stubs(:class_probabilities).returns([0.25,0.25,0.25,0.25]) 
      end
      test "should return close to 2.0 when the entropy of that distribution is requested" do
        assert_in_delta 2.0, @analyzer.entropy(@distribution), 0.01
      end
    end

    context "given an object that provides a collection of 6 uniform class probabilities" do
      setup do
        @distribution.stubs(:class_probabilities).returns([0.167,0.167,0.167,0.167,0.167,0.167]) 
      end
      test "should return close to 2.585 when the entropy of that distribution is requested" do
        assert_in_delta 2.585, @analyzer.entropy(@distribution), 0.01
      end
    end
  end

end
