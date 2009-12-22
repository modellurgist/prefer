
require 'lib/prefer/preference/profile_probability_mapper'
require 'permutation'

class DistributionFactory

  def initialize
    @random_service = RandomService.new
    @probability_function_generator = ProbabilityMassFunctionGenerator.new
    @profile_probability_mapper = ProfileProbabilityMapper.new
  end

  def build_function_having_random_profile_assignment(alternatives)
    #set_true_random
    function = build_function_with_integer_probability_mappings(alternatives)
    integers = function.integers
    profiles = permutations_of(alternatives)
    profile_integer_relation = @profile_probability_mapper.random_profile_assignment(profiles, integers)
    function.finish_mapping_all_classes(profile_integer_relation)
    #unset_true_random
    function
  end

  # private

  def unset_true_random
    RandomService.set_random_number_generator_name("pseudorandom")
  end

  def set_true_random
    RandomService.set_random_number_generator_name("true_random")
  end

  def build_function_with_integer_probability_mappings(alternatives)
    integer_distribution = build_unnormalized_distribution(alternatives)
    @probability_function_generator.build_from_integers(integer_distribution)
  end

  def number_of_permutations_of(alternatives)
    permutations_of(alternatives).size
  end

  def permutations_of(alternatives)
    permutation_generator = Permutation.for(alternatives)
    permutation_generator.collect {|permutation| permutation.project}
  end


end
