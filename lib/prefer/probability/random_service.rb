
require 'random/online'

class RandomService

  def initialize
    @true_generator = Random::RandomOrg.new
  end

  # assumption for consistency with Kernal.rand:  
  #   delegate should return a random floating point number between 0 and 1 when passed 0 or nil (which should default to 0)
  def select_integer_from_zero_to_one_less_than(highest_integer)
    rand(highest_integer)
  end

  # private



end
