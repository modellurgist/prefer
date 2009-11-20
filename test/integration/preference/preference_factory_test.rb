
require 'test/backend_test_helper'
require 'lib/prefer/probability/probability_distribution'
require 'lib/prefer/probability/distribution_analyzer'

class PreferenceFactoryTest < Test::Unit::TestCase

  context "a large number" do
    setup do
      @sample_size = 4000
    end
    context "of preference profiles generated by uniform random selection over all 6 permutations of 3 alternatives" do
      setup do
        alternatives = ["a", "b", "c"]
        factory = PreferenceFactory.new
        @profiles = Array.new
        @sample_size.times do |i|
          @profiles << factory.uniformly_random_permutation(alternatives)
        end
        @distribution = ProbabilityDistribution.new(@profiles)
      end
      test "should produce the 6 unique profiles" do
        assert_equal 6, @profiles.uniq.size
      end
      test "should produce a frequency distribution with 6 values" do
        assert_equal 6, @distribution.class_probabilities.size
      end
      test "should produce a frequency distribution with values that each roughly equal 0.16667" do
        @distribution.class_probabilities.each do |probability|
          assert_in_delta 0.16667, probability, 0.03
        end
      end
      test "should produce a frequency distribution with an entropy within 5% of log base 2 of 6, 2.585" do
        distribution_analyzer = DistributionAnalyzer.new
        assert_in_delta 2.585, distribution_analyzer.entropy(@distribution), 0.1, "<values: #{@distribution.class_probabilities.to_s}>" 
      end
    end
  end

end
