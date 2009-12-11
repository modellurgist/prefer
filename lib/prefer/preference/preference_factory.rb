
require 'lib/prefer/probability/random_service'

class PreferenceFactory

  def initialize(alternatives)
    @alternatives = alternatives
    @random = RandomService.new
  end

  def uniformly_random_permutation
    @alternatives.sort_by {|alternative| @random.select_integer_from_zero_to_one_less_than(0)}
  end
  
  # private


end
