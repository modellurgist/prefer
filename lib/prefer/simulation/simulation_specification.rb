
class SimulationSpecification

  attr_reader :alternatives, :population_size, :voting_method, :sample_size_increment, :specifications


  def initialize(parameters)
    @specifications = parameters
    if    (@alternatives = parameters[:alternatives]).nil? then throw :null_parameter 
    elsif (@population_size = parameters[:population_size]).nil? then throw :null_parameter 
    elsif (@sample_size_increment = parameters[:sample_size_increment]).nil? then throw :null_parameter 
    #elsif (@increment_type = parameters[:increment_type]).nil? then throw :null_parameter 
    elsif (@voting_method = parameters[:voting_method]).nil? then throw :null_parameter 
    end
  end

end
