
class ProfileProbabilityMapper

  def random_profile_assignment(profiles, integers)
    profiles.collect {|profile| [profile, integers.shift]}
  end

end
