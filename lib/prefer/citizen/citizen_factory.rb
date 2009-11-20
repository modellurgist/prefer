
require 'lib/prefer/citizen/citizen'
require 'lib/prefer/preference/preference_factory'

class CitizenFactory

  def initialize(alternatives)
    @alternatives = alternatives
    @preference_factory = PreferenceFactory.new
  end

  def build
    Citizen.new(build_profile)
  end

  private

  def build_profile
    @preference_factory.uniformly_random_permutation(@alternatives)
  end
  

end
