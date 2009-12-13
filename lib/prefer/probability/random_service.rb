
require 'random/online'

class RandomService

  def initialize
    @true_generator = Random::RandomOrg.new
  end

  # assumption for consistency with Kernal.rand:  
  #   delegate should return a random floating point number between 0 and 1 when passed 0 or nil (which should default to 0)
  def select_integer_from_zero_to_one_less_than(highest_integer)
    self.send("select_#{random_number_generator_name}_integer_from_zero_to_one_less_than".to_sym, highest_integer)
  end

  # private

  def random_number_generator_name
    "pseudorandom"
  end

  def select_pseudorandom_integer_from_zero_to_one_less_than(highest_integer)
    rand(highest_integer)
  end

  def select_true_random_integer_from_zero_to_one_less_than(highest_integer)
    if (highest_integer == 0) # should return a decimal >= 0 and < 1.0
      return (select_true_random_integer_from_zero_to_one_less_than(1, 0, 9999) / 10000)
    else
      return @true_generator.randnum(1, 0, (highest_integer-1))
    end
  end

end
