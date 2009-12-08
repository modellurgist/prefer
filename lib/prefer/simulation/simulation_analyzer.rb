
require 'lib/prefer/analysis/simulation/simulation_analysis_factory'
require 'lib/prefer/voting/voting_method_factory'

class SimulationAnalyzer

  def initialize(results)
    if (@sample_repository = results).nil? then throw :null_parameter
    end
  end

  def results
    @sample_repository
  end

  def perform_simulation_analyses
    specifications = extract_specifications 
    voting_method = retrieve_voting_method(specifications)
    simulation_analysis_methods(voting_method).each {|method| method.run(@records)}
  end

  # private 

  def extract_specifications
    @sample_repository.simulation_specifications
  end

  def retrieve_voting_method(specifications)
    voting_method_name = specifications[:voting_method]
    voting_method_factory = VotingMethodFactory.new    
    voting_method_factory.build(voting_method_name)
  end

  def simulation_analysis_methods(voting_method)
    simulation_analysis_factory = SimulationAnalysisFactory.new
    methods = Array.new
    voting_method.compatible_simulation_analyses.each do |analysis_method|
      methods << simulation_analysis_factory.build(analysis_method)
    end
    methods
  end

end
