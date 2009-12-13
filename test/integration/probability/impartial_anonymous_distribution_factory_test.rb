
require 'test/test_helper'
require 'lib/prefer/probability/impartial_anonymous_distribution_factory'

class ImpartialAnonymousDistributionFactoryTest < Test::Unit::TestCase

  context "a new distribution factory object, the population size, and a set of 3 alternatives" do
    setup do
      @factory = ImpartialAnonymousDistributionFactory.new
      @population_size = 40
      @alternatives = [1, 2, 3]
    end
    context "a request to build partial mass function returns a partially complete probability mass function" do
      setup do
        @function = @factory.build_function_with_integer_probability_mappings(@alternatives)
      end
      test "function should have a nonempty set of integer probabilities" do
        assert @function.integer_probabilities.size > 0
      end
    end
    context "a request to build function with random assignment returns a complete probability function" do
      setup do
        @function = @factory.build_function_having_random_profile_assignment(@alternatives)
      end
      test "function should have its classes mapped" do
        assert @function.classes_mapped?
      end
    end
  end

end
