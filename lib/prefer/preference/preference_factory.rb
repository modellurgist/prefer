
require 'lib/prefer/probability/random'

class PreferenceFactory

  def initialize
    @random = Random.new
  end

  def uniformly_random_permutation(alternatives)
    alternatives.sort_by {|alternative| @random.select_one_integer(0)}
  end
  

end
