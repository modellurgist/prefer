
require 'lib/prefer/simulation/sample_repetition_repository'

class SampleRepository

  def initialize
    @sample_map = Hash.new
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

  def store_repetition_for_size(record, sample_size)
    unless (has_sample_size?(sample_size))
      new_sample_size(sample_size)
    end
    repetition_repo = retrieve_repetition_repository(sample_size)
    repetition_repo.store_repetition(record)
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