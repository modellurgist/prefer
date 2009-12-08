
class VotePercentComparisonMethod
 
  def initialize_results(results)
    if (@sample_repository = results).nil? then throw :null_parameter
    end
  end

  def run(results)
    initialize_results(results)
    compare_by_vote_percent
  end

  # private
  
  def compare_by_vote_percent
    # Note:  why just the first choice?  Seems vote percent calc depends on voting method, or?
    alternative =  population_sample_record.winning_alternative
    compare_vote_percent_for_each_sample(alternative)
  end
  

  def compare_vote_percent_for_each_sample(alternative)
    sample_sizes = @sample_repository.find_all_sample_sizes
    sample_sizes.each do |sample_size|
      repetitions = @sample_repository.find_all_repetitions_for_size(sample_size)
      repetitions.each do |repetition_record|
        sample_deviation = compare_vote_percent_for_sample(repetition_record, alternative)
        repetition_record.record_comparison(:vote_percent, alternative, sample_deviation)
      end
    end
  end
  
  def compare_vote_percent_for_sample(record, alternative)
    sample_vote_percent_for(record, alternative) - population_vote_percent_for(alternative)
  end

  def sample_vote_percent_for(record, alternative)
    #analysis_records_for_sample = record.analysis_records
    #vote_percent_values = analysis_records_for_sample[:vote_percent]
    #vote_percent_values[alternative]
    sample_vote_percent_values = record.analysis_records[:vote_percent]
    sample_vote_percent_values[alternative]
  end

  def full_population_size
    @sample_repository.population_size
  end

  def population_sample_record 
    @sample_repository.retrieve_population_record
  end

  def population_vote_percent_for(alternative)
    population_vote_percent[alternative] 
  end

  def population_vote_percent  
    population_sample_record.analysis_records[:vote_percent]
  end

end
