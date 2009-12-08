
class VotePercentComparisonMethod
 
  def initialize_results(results)
    if (@records = results).nil? then throw :null_parameter 
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
    all_keys = @records.keys
    integer_keys = all_keys.find_all {|key| key.class == Integer}
    integer_keys.each do |sample_size|
      sample_size.each do |sample_repetitions|
        sample_repetitions.each do |repetition_record|
          sample_deviation = compare_vote_percent_for_sample(repetition_record, alternative)
          repetition_record.record_comparison(:vote_percent, alternative, sample_deviation)
        end
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
    @records.keys.max  
  end

  def population_sample_record 
    @records[:population_result_record]
  end

  def population_vote_percent_for(alternative)
    population_vote_percent[alternative] 
  end

  def population_vote_percent  
    population_sample_record.analysis_records[:vote_percent]
  end

end
