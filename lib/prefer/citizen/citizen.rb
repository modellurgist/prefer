
class Citizen

  def initialize(profile)
    throw :invalid_profile unless profile.respond_to?(:each)
    @profile = profile
  end
  
  attr_reader :profile

  def first_choice
    @profile.first
  end

end
