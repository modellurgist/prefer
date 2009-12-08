
require 'lib/prefer/simulation/sample_repetition_repository'

class SampleRepository

  attr_reader :sample_map # this should only be used during informal testing, then removed

  def initialize
    @sample_map = Hash.new
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

  def store_repetition_for_size(record, sample_size)
    unless (has_sample_size?(sample_size))
      new_sample_size(sample_size)
    end
    repetition_repo = retrieve_repetition_repository(sample_size)
    repetition_repo.store_repetition(record)
  end

  def find_all_repetitions_for_size(sample_size)

  end

  def find_any_repetition_for_size(sample_size)
    repetition_repo = retrieve_repetition_repository(sample_size)
    repetition_repo.find_any_repetition
  end

  def simulation_specifications
    record = find_any_repetition
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