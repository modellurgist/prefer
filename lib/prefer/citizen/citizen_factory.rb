
require 'lib/prefer/citizen/citizen'
require 'lib/prefer/preference/preference_factory'

class CitizenFactory

  def initialize(alternatives)
    @alternatives = alternatives
    @preference_factory = PreferenceFactory.new(alternatives)
  end

  def build_collection(population_size)
    population_size.times.collect { build }
  end

  # private

  def build
    Citizen.new(build_profile)
  end

  def build_profile
    @preference_factory.uniformly_random_permutation
  end
  

end
