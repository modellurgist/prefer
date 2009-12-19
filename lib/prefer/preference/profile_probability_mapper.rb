
require 'lib/prefer/probability/random_service'

class ProfileProbabilityMapper

  def initialize
    @random = RandomService.new
  end

  def random_profile_assignment(profiles, integers)
    randomized_profiles = profiles.sort_by {|alternative| @random.select_integer_from_zero_to_one_less_than(0)}
    integers_copied = integers.dup
    randomized_profiles.collect {|profile| [profile, integers_copied.shift]}
  end

end
