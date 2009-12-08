
require 'lib/prefer/constants/simulation_constants'
require 'lib/prefer/mode/mode_factory'

class Simulation < ActiveRecord::Base
  belongs_to :alternatives_set
  attr_accessor :report_string

  def alternatives_set_name 
    unless self.alternatives_set.nil?
      self.alternatives_set.description
    end
  end

  def run
    mode_factory = ModeFactory.new
    runner = mode_factory.build_runner(self.mode)
    specifications = build_specifications_hash
    @report_string = runner.run_with_hash_parameters(specifications, EXPORT_ON)
  end

  def available_simulation_modes
    {"RangeRunner" => "RangeRunner"}
  end

  # private

  def build_specifications_hash
    parameters = Hash.new
    parameters[:alternatives] = self.alternatives 
    parameters[:population_size] = self.population_size 
    parameters[:voting_method] = self.voting_method 
    parameters[:sample_size_increment] = self.sample_size_increment
    parameters
  end

  def alternatives
    alternatives_set = self.alternatives_set
    alternatives_set.alternatives.collect {|alternative| alternative.alternative}
  end
  
end
