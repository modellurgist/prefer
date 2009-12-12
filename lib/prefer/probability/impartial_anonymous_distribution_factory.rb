
require 'lib/prefer/probability/distribution_factory'
require 'permutation'

class ImpartialAnonymousDistributionFactory < DistributionFactory

  #def build_with_arbitrary_assignment(alternatives, population_size)
  #end
  def build_function_with_integer_probability_mappings(alternatives)
    integer_distribution = build_unnormalized_distribution(alternatives)
    @probability_function_generator.build_from_integers(integer_distribution)
  end

  # private
  
  def build_unnormalized_distribution(alternatives)
    number_of_permutations_of(alternatives).times.collect do
      @random_service.select_integer_from_zero_to_one_less_than(10000)
    end
  end

end
