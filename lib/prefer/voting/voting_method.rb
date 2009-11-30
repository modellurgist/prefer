

class VotingMethod

  attr_reader :analytical_methods

  def initialize
    @analytical_methods = Array.new
    register_all_compatible_sample_analyses
  end

  # private 

  def compatible_sample_analyses
    # define in concrete class
    []
  end

  def compatible_simulation_analyses
    # define in concrete class
    []
  end

  def collect_preference_profiles(citizens)
    citizens.collect {|citizen| citizen.profile}
  end

  def register_all_compatible_sample_analyses
    method_factory = AnalyticalMethodFactory.new
    compatible_sample_analyses.each do |analysis|
      register_analytical_method(method_factory.build(analysis))
    end
  end
  
  def register_analytical_method(method)
    @analytical_methods << method
  end
  

end
