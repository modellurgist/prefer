
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
    #specifications = build_specifications_hash
    #@report_string = runner.run_with_hash_parameters(specifications, EXPORT_ON)
    @report_string = runner.run_with_hash_parameters(build_specifications_hash_from_simulation, EXPORT_ON)
  end

  def available_simulation_modes
    modes.sort
  end

  def available_voting_methods
    methods = {"Plurality" => "plurality",
               "Instant Runoff Vote" => "irv"
              }
    methods.sort
  end

  # private

  def modes
    {"Define a range of sample sizes. For each constant step within it, run one election for each repetition" => "RangeRunner"}
  end

  def build_specifications_hash_from_simulation
    simulation_attributes = self.attributes
    alternatives = self.alternatives_set.alternatives.collect {|alternative| alternative.alternative}
    simulation_attributes[:alternatives] = alternatives
    simulation_attributes
  end

  #def build_specifications_hash  # deprecated !
  #  parameters = Hash.new
  #  parameters[:alternatives] = self.alternatives
  #  parameters[:population_size] = self.population_size
  #  parameters[:voting_method] = self.voting_method
  #  parameters[:sample_size_increment] = self.sample_size_increment
  #  parameters
  #end

  def alternatives
    alternatives_set = self.alternatives_set
    alternatives_set.alternatives.collect {|alternative| alternative.alternative}
  end
  
end
