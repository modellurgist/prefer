
require 'lib/prefer/statistics/sample_statistics_analyzer'

class SampleStatisticsSuite

  def initialize
    @statistics_hash = Hash.new
    @statistics_calculator = SampleStatisticsAnalyzer.new
  end

  def run(sample_repository)
    initialize_results(sample_repository)
    run_statistics_for_all_sample_sizes
  end

  # private

  def initialize_results(sample_repository)
    if (@sample_repository = sample_repository).nil? then throw :null_parameter
    end
  end

  def run_statistics_for_all_sample_sizes
    @sample_repository.find_all_sample_sizes.each do |sample_size|
      @statistics_hash.clear
      repetition_analysis_symbols.each do |analysis_symbol|
        add_statistic(:variance, analysis_symbol, sample_size, variance_closure)
        add_statistic(:mean, analysis_symbol, sample_size, mean_closure)
        add_statistic(:lower_confidence_limit, analysis_symbol, sample_size, lower_confidence_limit_closure)
        add_statistic(:upper_confidence_limit, analysis_symbol, sample_size, upper_confidence_limit_closure)
        add_statistic(:confidence_interval_width, analysis_symbol, sample_size, confidence_interval_width_closure)
      end
      store_statistics_for_sample_size(sample_size)
    end
  end

  def store_statistics_for_sample_size(sample_size)
    @sample_repository.store_statistics_for_sample_size(@statistics_hash.dup, sample_size)
  end

  def repetition_analysis_symbols
    @sample_repository.repetition_analysis_symbols
  end

  def variance_closure
    return lambda do |sample_values, population_mean|
      @statistics_calculator.sample_variance_given_population_mean(sample_values, population_mean)
    end
  end
  
  def mean_closure
    return lambda do |sample_values, population_mean|
      @statistics_calculator.sample_mean(sample_values)
    end
  end

  def lower_confidence_limit_closure
    return lambda do |sample_values, population_mean|
      @statistics_calculator.lower_confidence_limit(sample_values, population_mean)
    end
  end

  def upper_confidence_limit_closure
    return lambda do |sample_values, population_mean|
      @statistics_calculator.upper_confidence_limit(sample_values, population_mean)
    end
  end

  def confidence_interval_width_closure
    return lambda do |sample_values, population_mean|
      @statistics_calculator.confidence_interval_width(sample_values, population_mean)
    end
  end

  def add_statistic(statistic_symbol, analysis_symbol, sample_size, statistic_closure)
    population_record = @sample_repository.retrieve_population_record
    population_analysis_records = population_record.analysis_records

    repetitions = @sample_repository.find_all_repetitions_for_size(sample_size)
    a_repetition = repetitions.first
    a_set_of_analysis_records = a_repetition.analysis_records

    some_records_for_this_analysis = a_set_of_analysis_records[analysis_symbol]
    variable_symbols = some_records_for_this_analysis.keys

    variable_statistic_hash = Hash.new

    variable_symbols.each do |variable_symbol|
      sample_values = repetitions.collect do |repetition|
                        analyses = repetition.analysis_records
                        analysis = analyses[analysis_symbol]
                        analysis[variable_symbol]
                      end
      population_analyses = population_analysis_records[analysis_symbol]
      population_mean = population_analyses[variable_symbol]
      variable_statistic_hash[variable_symbol] = statistic_closure.call(sample_values, population_mean)
    end
    @statistics_hash[statistic_symbol] = {analysis_symbol => variable_statistic_hash}
  end

end
