
require 'lib/prefer/probability/random'

class PreferenceFactory

  def initialize(alternatives)
    @alternatives = alternatives
    @random = Random.new
  end

  def uniformly_random_permutation
    @alternatives.sort_by {|alternative| @random.select_one_integer(0)}
  end
  
  # private


end
