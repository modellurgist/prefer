
require 'lib/prefer/probability/random_service'

class PreferenceFactory

  def initialize(alternatives)
    @alternatives = alternatives
    @random = RandomService.new
  end

  def build_all_profiles_from_approximate_uniform_distribution(population_size)
    population_size.times.collect {uniformly_random_permutation}
  end

  # private

  def uniformly_random_permutation # DEPRECATED as public, but use as private
    @alternatives.sort_by {|alternative| @random.select_integer_from_zero_to_one_less_than(0)}
  end


end
