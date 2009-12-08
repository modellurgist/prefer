
class SimulationSpecification

  attr_reader :alternatives, :population_size, :voting_method, :sample_size_increment, :specifications,
              :repetitions, :sample_size_minimum, :sample_size_maximum, :sample_size  # deprecated !


  def initialize(parameters)
    @specifications = parameters
    if    (@alternatives = parameters[:alternatives]).nil? then throw :null_parameter 
    elsif (@population_size = parameters[:population_size]).nil? then throw :null_parameter 
    #elsif (@increment_type = parameters[:increment_type]).nil? then throw :null_parameter 
    elsif (@voting_method = parameters[:voting_method]).nil? then throw :null_parameter 
    elsif (@repetitions = parameters[:repetitions]).nil? then throw :null_parameter
    elsif (@sample_size_increment = parameters[:sample_size_increment]).nil? then throw :null_parameter
    elsif (@sample_size_minimum = parameters[:sample_size_minimum]).nil? then throw :null_parameter
    elsif (@sample_size_maximum = parameters[:sample_size_maximum]).nil? then throw :null_parameter
    end
    set_optional_parameters(parameters)
  end

  def set_optional_parameters(parameters)
    unless parameters[:sample_size].nil? then @sample_size = parameters[:sample_size]
    end # deprecated !!
  end

end
