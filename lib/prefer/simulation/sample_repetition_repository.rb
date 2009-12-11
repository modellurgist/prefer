
class SampleRepetitionRepository

  def initialize
    @repetition_count = 0
    @repetition_map = Hash.new
    @statistics = Hash.new
  end

  def repetition_count
    @repetition_map.size
  end

  def store_repetition(record)
    @repetition_map[@repetition_count] = record
    @repetition_count = @repetition_count.next
  end

  def find_all_as_unindexed
    @repetition_map.values
  end

  def store_statistics(statistics_hash)
    @statistics = statistics_hash
  end

  def find_statistic_for_sample_size(statistic_symbol, analysis_symbol, variable_symbol)
    results_for_statistic = @statistics[statistic_symbol]
    statistic_results_for_analysis = results_for_statistic[analysis_symbol]
    statistic_results_for_analysis[variable_symbol]
  end

  def find_any_repetition
    first_repetition
  end

  # private

  def first_repetition
    unless (@repetition_count == 0) then return @repetition_map[0]
    end
  end


end
