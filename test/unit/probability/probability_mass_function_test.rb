
require 'test/test_helper'
require 'lib/prefer/probability/probability_mass_function_generator'
require 'lib/prefer/probability/probability_mass_function'

class ProbabilityMassFunctionTest < Test::Unit::TestCase

  context "a function built from a sequence of integers" do
    setup do
      integers = [4, 4, 1, 1]
      generator = ProbabilityMassFunctionGenerator.new
      @function = generator.build_from_integers(integers)
    end
    context "and a mapping of classes to integers is provided in request to map all classes" do
      setup do
        @class_integer_map = {"apple" => 4, "orange" => 4, "banana" => 1, "kiwi" => 1}
        @function.finish_mapping_all_classes(@class_integer_map)
      end
      test "a request for classes should return all of the mapped classes" do
        assert_equal @class_integer_map.keys, @function.classes
      end
      test "probabilities for integers should equal probabilities for classes" do
        assert_equal @function.integer_probabilities, @function.class_probabilities
      end
    end
  end
end
