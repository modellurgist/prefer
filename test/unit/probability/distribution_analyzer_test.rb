
require 'test/test_helper'
require 'lib/prefer/probability/distribution_analyzer'

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

    context "given an object that provides a relation of 6 classes to nonuniform probabilities" do
      setup do
        relation = [ [["a","b","c"], 0.4], [["a","c","b"], 0.3], [["b","a","c"], 0.2],[["c","a","b"], 0.1], [["b","c","a"], 0.0], [["c","b","a"], 0.0] ]
        @function = ProbabilityMassFunctionTransient.new
        relation.each do |pair|
          @function.add_class_mapping(pair.first, pair.last)
        end
      end
      test "should return the correct value for the euclidean_normal_of that distribution's pairwise_election_vector when requested" do
        assert_in_delta 1.02, @analyzer.euclidean_normal_of_pairwise_election_vector(@function), 0.01
      end
    end

  end

end
