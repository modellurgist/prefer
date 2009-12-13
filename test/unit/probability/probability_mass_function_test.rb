
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
      test "probability for orange should be 0.4" do
        assert_equal 0.4, @function.probability_for_class("orange")
      end
      context "a population of size 100 is requested" do
        setup do
          @preference_orderings = @function.build_population_of_size(100)
        end
        test "should build a collection of exactly 100 objects" do
          assert_equal 100, @preference_orderings.size
        end
        test ", taken from each class that has a non zero probability and is of sufficient magnitude" do

        end
        test "that very closely matches its" do

        end
      end
    end
  end
end
