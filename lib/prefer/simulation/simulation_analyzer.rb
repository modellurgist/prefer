
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


  # to extract
  
  #def compare_by_vote_percent
  #  # Note:  why just the first choice?  Seems vote percent calc depends on voting method, or?
  #  alternative =  population_sample_record.winning_alternative
  #  compare_vote_percent_for_each_sample(alternative)
  #end
  #

  #def compare_vote_percent_for_each_sample(alternative)
  #  @records.each_value do |record|
  #    sample_deviation = compare_vote_percent_for_sample(record, alternative)
  #    record.record_comparison(:vote_percent, alternative, sample_deviation)
  #  end
  #end
  #
  #def compare_vote_percent_for_sample(record, alternative)
  #  sample_vote_percent_for(record, alternative) - population_vote_percent_for(alternative)
  #end

  #def sample_vote_percent_for(record, alternative)
  #  #analysis_records_for_sample = record.analysis_records
  #  #vote_percent_values = analysis_records_for_sample[:vote_percent]
  #  #vote_percent_values[alternative]
  #  
  #  sample_vote_percent_values = record.analysis_records[:vote_percent]
  #  sample_vote_percent_values[alternative]
  #end

  #def full_population_size
  #  @records.keys.max  
  #end

  #def population_sample_record 
  #  @records[full_population_size]
  #end

  #def population_vote_percent_for(alternative)
  #  population_vote_percent[alternative] 
  #end

  #def population_vote_percent  
  #  population_sample_record.analysis_records[:vote_percent]
  #end


end
