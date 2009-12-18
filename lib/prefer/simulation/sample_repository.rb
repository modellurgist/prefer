
require 'lib/prefer/simulation/sample_repetition_repository'
require 'lib/prefer/probability/probability_mass_function_generator'
require 'lib/prefer/probability/distribution_analyzer'

class SampleRepository

  def initialize
    @sample_map = Hash.new
    @distribution_analyzer = DistributionAnalyzer.new
  end

  def empty?
    sample_count == 0
  end

  def sample_count
    @sample_map.size
  end

  def has_sample_size?(sample_size)
    @sample_map.has_key?(sample_size)
  end

  def store_population_record(record)
    unless (@population_record.nil?) then throw :population_record_exists
    end
    @population_record = record
  end

  def population_size
    @population_record.population_size
  end

  def retrieve_population_record
    @population_record
  end

  def population_repetition_analysis_for(analysis_symbol)
    retrieve_population_record.analysis_records[analysis_symbol]
  end

  def store_repetition_for_size(record, sample_size)
    unless (has_sample_size?(sample_size))
      new_sample_size(sample_size)
    end
    repetition_repo = retrieve_repetition_repository(sample_size)
    repetition_repo.store_repetition(record)
  end

  def store_statistics_for_sample_size(statistics_hash, sample_size)
    sample_repetition_repository = retrieve_repetition_repository(sample_size)
    sample_repetition_repository.store_statistics(statistics_hash)
  end

  def find_statistic_for_sample_size(sample_size, statistic_symbol, analysis_symbol, variable_symbol)
    repetitions_repository = retrieve_repetition_repository(sample_size)
    repetitions_repository.find_statistic_for_sample_size(statistic_symbol, analysis_symbol, variable_symbol)
  end

  def find_all_repetitions_for_all_sizes
    repetition_repos = @sample_map.values
    collection = repetition_repos.collect do |repetition_repo|
                   repetition_repo.find_all_as_unindexed
                 end
    collection.flatten
  end

  # should probably map a size to a collection of record objects (to avoid duplicate keys)
  def generate_hash_of_collected_repetitions_by_sample_size
    return_value = Hash.new
    find_all_sample_sizes.each do |sample_size|
      repetitions = find_all_repetitions_for_size(sample_size)
      return_value[sample_size] = repetitions
    end
    return_value
  end

  def find_all_repetitions_for_size(sample_size)
    repetition_repo = retrieve_repetition_repository(sample_size)
    repetition_repo.find_all_as_unindexed
  end

  def find_any_repetition_for_size(sample_size)
    repetition_repo = retrieve_repetition_repository(sample_size)
    repetition_repo.find_any_repetition
  end

  def simulation_specifications
    record = retrieve_population_record
    record.specifications
  end

  def find_all_sample_sizes
    @sample_map.keys
  end

  def repetition_analysis_symbols
    repetition = find_any_repetition
    repetition.available_analyses
  end

  def class_probability_relation
    probability_mass_function.class_probability_relation
  end

  # Analyses to factor out into separate object

  def entropy_of_actual_preference_distribution
    function = probability_mass_function
    @distribution_analyzer.entropy(function)
  end

  def euclidean_normal_of_pairwise_election_vector_for_actual_distribution
    function = probability_mass_function
    @distribution_analyzer.euclidean_normal_of_pairwise_election_vector(function)
  end

  def population_ballots
    retrieve_population_record.ballots
  end

  def probability_mass_function
    if (@probability_mass_function.nil?)
      function_generator = ProbabilityMassFunctionGenerator.new
      @probability_mass_function = function_generator.build_from_population(population_ballots)
    end
    @probability_mass_function
  end

  def entropy_of_uniform_distribution
    number_alternatives = @population_record.number_alternatives
    number_permutations = (2..number_alternatives).inject(1) {|product, integer| product * integer}
    @distribution_analyzer.log_base_2(number_permutations)
  end

  # private

  def find_any_repetition
    size = find_any_sample_size
    repetition_repo = retrieve_repetition_repository(size)
    repetition_repo.find_any_repetition
  end

  def new_sample_size(sample_size)
    @sample_map[sample_size] = SampleRepetitionRepository.new
  end

  def retrieve_repetition_repository(sample_size)
    @sample_map[sample_size]
  end

  def find_any_sample_size
    sizes = find_all_sample_sizes
    unless (sizes.nil?) then return sizes.find {|size| size > 0}
    end
  end

end