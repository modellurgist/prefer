
require 'lib/prefer/analysis/simulation/simulation_analysis_factory'
require 'lib/prefer/voting/voting_method_factory'

class SimulationAnalyzer

  attr_reader :records

  def initialize(results)
    if (@records = results).nil? then throw :null_parameter 
    end
  end

  def perform_sample_comparisons
    specifications = extract_specifications 
    voting_method = retrieve_voting_method(specifications)
    simulation_analysis_methods(voting_method).each {|method| method.run(@records)}
  end

  # private 

  def simulation_analysis_methods(voting_method)
    simulation_analysis_factory = SimulationAnalysisFactory.new
    methods = Array.new
    voting_method.compatible_simulation_analyses.each do |analysis_method|
      methods << simulation_analysis_factory.build(analysis_method) 
    end
    methods 
  end

  def retrieve_voting_method(specifications)
    voting_method_name = specifications[:voting_method]
    voting_method_factory = VotingMethodFactory.new    
    voting_method_factory.build(voting_method_name)
  end

  def extract_specifications
    a_record = @records.find {|sample_size,record| sample_size > 0}
    a_record[1].specifications 
  end

end
