
require 'lib/prefer/probability/random_service'
require 'lib/prefer/probability/impartial_anonymous_distribution_factory'
require 'lib/prefer/probability/bouncing_ball_distribution_factory'

class PreferenceFactory

  def initialize(alternatives)
    @alternatives = alternatives
    @random = RandomService.new
  end

  def build_all_profiles_from_impartial_anonymous_distribution(population_size)
    distribution_factory = ImpartialAnonymousDistributionFactory.new
    build_profiles_from_probability_function(distribution_factory, population_size)
  end

  def build_all_profiles_from_bouncing_ball_distribution(population_size)
    distribution_factory = BouncingBallDistributionFactory.new
    build_profiles_from_probability_function(distribution_factory, population_size)
  end

  def build_all_profiles_from_approximate_uniform_distribution(population_size)
    population_size.times.collect {uniformly_random_permutation}
  end

  # private

  def build_profiles_from_probability_function(distribution_factory, population_size)
    probability_function = distribution_factory.build_function_having_random_profile_assignment(@alternatives)
    probability_function.build_population_of_size(population_size)
  end

  def uniformly_random_permutation # DEPRECATED as public, but use as private (consider moving to pmf gen.)
    @alternatives.sort_by {|alternative| @random.select_integer_from_zero_to_one_less_than(0)}
  end

end
