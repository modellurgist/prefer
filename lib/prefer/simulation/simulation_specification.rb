
class SimulationSpecification

  attr_reader :alternatives, :population_size, :voting_method, :sample_size_increment, :specifications,
              :repetitions, :sample_size_minimum, :sample_size_maximum,
              :sample_size  # deprecated !

  def initialize(parameters)  # TO-DO: rewrite to use only simulation properties instead of hash? OR convert to hash first
    @specifications = convert_parameter_keys_to_symbols(parameters)
    if    (@alternatives = @specifications[:alternatives]).nil? then throw :null_parameter
    elsif (@population_size = @specifications[:population_size]).nil? then throw :null_parameter
    #elsif (@increment_type = @specifications[:increment_type]).nil? then throw :null_parameter
    elsif (@voting_method = @specifications[:voting_method]).nil? then throw :null_parameter
    elsif (@repetitions = @specifications[:repetitions]).nil? then throw :null_parameter
    elsif (@sample_size_increment = @specifications[:sample_size_increment]).nil? then throw :null_parameter
    elsif (@sample_size_minimum = @specifications[:sample_size_minimum]).nil? then throw :null_parameter
    elsif (@sample_size_maximum = @specifications[:sample_size_maximum]).nil? then throw :null_parameter
    end
    set_optional_parameters(@specifications)
  end

  # private

  def convert_parameter_keys_to_symbols(parameters)
    converted_parameters = Hash.new
    parameters.each do |key, value|
      converted_parameters[key.to_sym] = value
    end
    converted_parameters
  end

  def set_optional_parameters(parameters)
    unless parameters[:sample_size].nil? then @sample_size = parameters[:sample_size]
    end # deprecated !!
  end


end
