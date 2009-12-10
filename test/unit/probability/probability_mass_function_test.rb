
require 'test/test_helper'
require 'lib/prefer/probability/probability_mass_function_generator'
require 'lib/prefer/probability/probability_mass_function'

class ProbabilityMassFunctionTest < Test::Unit::TestCase

  context "when initialized with a sequence of integers" do
    setup do
      integers = [4, 2, 1, 3]
      generator = ProbabilityMassFunctionGenerator.new
      @function = generator.build_from_integers(integers)
    end
    test "should provide the correct sequence of probabilities derived from their relative size" do
      assert_equal [0.4, 0.2, 0.1, 0.3], @function.class_probabilities
    end
  end

end
