
class SimulationSpecification

  attr_reader :alternatives, :population_size, :voting_method, :sample_size_increment, :specifications,
              :repetitions, :sample_size_minimum, :sample_size_maximum, :distribution_type,
              :sample_size  # deprecated !

  def initialize(parameters) 
    @specifications = convert_parameter_keys_to_symbols(parameters)
    remove_unnecessary_parameters
    if    (@alternatives = @specifications[:alternatives]).nil? then throw :null_parameter
    elsif (@population_size = @specifications[:population_size]).nil? then throw :null_parameter
    #elsif (@increment_type = @specifications[:increment_type]).nil? then throw :null_parameter
    elsif (@voting_method = @specifications[:voting_method]).nil? then throw :null_parameter
    elsif (@repetitions = @specifications[:repetitions]).nil? then throw :null_parameter
    elsif (@distribution_type = @specifications[:distribution_type]).nil? then throw :null_parameter
    end
    set_case_specific_parameters(@specifications)
  end

  # private

  def remove_unnecessary_parameters
    @specifications.delete(:updated_at)
    @specifications.delete(:created_at)
  end

  def set_case_specific_parameters(parameters)  
    unless @specifications[:sample_size_increment].nil? then @sample_size_increment = @specifications[:sample_size_increment]
    end
    unless @specifications[:sample_size_minimum].nil? then @sample_size_minimum = @specifications[:sample_size_minimum]
    end
    unless @specifications[:sample_size_maximum].nil? then @sample_size_maximum = @specifications[:sample_size_maximum]
    end
    unless @specifications[:sample_size].nil? then @sample_size = @specifications[:sample_size]
    end 
  end

  def convert_parameter_keys_to_symbols(parameters)
    converted_parameters = Hash.new
    parameters.each do |key, value|
      converted_parameters[key.to_sym] = value
    end
    converted_parameters
  end


end
