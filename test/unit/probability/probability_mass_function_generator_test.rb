
require 'test/test_helper'
require 'lib/prefer/probability/probability_mass_function_generator'

class ProbabilityMassFunctionGeneratorTest < Test::Unit::TestCase

  context "when initialized with a population of 12 preference profiles with 2 for each of the 6 permutations of 3 alternatives" do
    setup do
      @profiles = Array.new
      permutations = Array.new
      permutations << ["a","b","c"] << ["a","c","b"] << ["b","a","c"] << ["b","c","a"] << ["c","a","b"] << ["c","b","a"]
      permutations.each do |perm|
        @profiles << perm << perm 
      end
      @generator = ProbabilityMassFunctionGenerator.new
      @distribution = @generator.build_from_population(@profiles)
    end
    test "should produce the 6 unique profiles" do
      assert_equal 6, @profiles.uniq.size
    end
    test "should return collection of 6 profiles when requested to identify unique classes" do
      assert_equal 6, @distribution.classes.size
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

  context "when initialized with a sequence of integers" do
    setup do
      integers = [4, 2, 1, 3]
      generator = ProbabilityMassFunctionGenerator.new
      @function = generator.build_from_integers(integers)
    end
    test "function integer probability mapping should not be empty" do
      assert_equal false, @function.integer_probability_map.empty?
    end
    test "should provide the correct sequence of probabilities derived from their relative size" do
      assert_equal [0.4, 0.2, 0.1, 0.3].sort, @function.class_probabilities
    end
  end

end
