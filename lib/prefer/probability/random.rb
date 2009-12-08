
class Random

  # assumption for consistency with Kernal.rand:  
  #   delegate should return a random floating point number between 0 and 1 when passed 0 or nil (which should default to 0)
  def select_one_integer(highest_integer)
    rand(highest_integer)
  end

  # private



end
