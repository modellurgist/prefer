
require 'test/backend_test_helper'

class ProbabilityDistributionTest < Test::Unit::TestCase

  context "when initialized with a population of 12 preference profiles with 2 for each of the 6 permutations of 3 alternatives" do
    setup do
      @profiles = Array.new
      permutations = Array.new
      permutations << ["a","b","c"] << ["a","c","b"] << ["b","a","c"] << ["b","c","a"] << ["c","a","b"] << ["c","b","a"]
      permutations.each do |perm|
        @profiles << perm << perm 
      end
      @distribution = ProbabilityDistribution.new(@profiles)
    end
    test "should produce the 6 unique profiles" do
      assert_equal 6, @profiles.uniq.size
    end
    test "should return collection of 6 profiles when requested to identify unique classes" do
      assert_equal 6, @distribution.identify_unique_classes.size
    end
    test "should produce a frequency distribution with 6 values" do
      assert_equal 6, @distribution.class_probabilities.size
    end
    test "should produce a uniform frequency distribution with values that each roughly equal 0.16667" do
      class_probabilities = @distribution.class_probabilities
      class_probabilities.each do |value|
        assert_in_delta 0.16667, value, 0.00002
      end
    end
  end

end
