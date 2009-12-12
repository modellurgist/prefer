
require 'lib/prefer/preference/profile_probability_mapper'
require 'permutation'

class DistributionFactory

  def initialize
    @random_service = RandomService.new
    @probability_function_generator = ProbabilityMassFunctionGenerator.new
    @profile_probability_mapper = ProfileProbabilityMapper.new
  end

  # private

  def number_of_permutations_of(alternatives)
    permutations_of(alternatives).size
  end

  def permutations_of(alternatives)
    permutation_generator = Permutation.for(alternatives)
    permutation_generator.collect {|permutation| permutation.project}
  end


end
