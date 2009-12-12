
require 'test/test_helper'
require 'lib/prefer/probability/impartial_anonymous_distribution_factory'

class ImpartialAnonymousDistributionFactoryTest < Test::Unit::TestCase

  context "a new distribution factory object, the population size, and a set of 3 alternatives" do
    setup do
      @factory = ImpartialAnonymousDistributionFactory.new
      @population_size = 40
      @alternatives = [1, 2, 3]
    end
    context "a request to build unnormalized distribution for 3 alternatives" do
      setup do
        @unnormalized_distribution = @factory.build_unnormalized_distribution(@alternatives)
      end
      test "should return a collection of 6 items, representing permutations of alternatives" do
        assert_equal 6, @unnormalized_distribution.size
      end
      test "each item should be an integer greater than zero and less than 10000, inclusive" do
        assert @unnormalized_distribution.all? {|count| count >= 0 && count <= 9999}
      end
    end
  end

end
