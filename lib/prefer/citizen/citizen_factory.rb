
require 'lib/prefer/citizen/citizen'
require 'lib/prefer/preference/preference_factory'

class CitizenFactory

  def initialize(alternatives)
    @alternatives = alternatives
    @preference_factory = PreferenceFactory.new(alternatives)
  end

  def build_collection(population_size)
    profiles = build_all_profiles(population_size, :approximate_uniform)
    profiles.collect! do |profile|
      build_with_profile(profile)
    end
  end

  # private

  def build_all_profiles(population_size, distribution_symbol)
    # TODO: don't use collect, just ask preference factory for collection with given distribution
    @preference_factory.send("build_all_profiles_from_#{distribution_symbol.to_s}_distribution".to_sym, population_size)
  end

  def build_with_profile(profile)
    Citizen.new(profile)
  end

  def build #DEPRECATED
    Citizen.new(build_profile)
  end

  def build_profile # DEPRECATED
    @preference_factory.uniformly_random_permutation
  end


end
