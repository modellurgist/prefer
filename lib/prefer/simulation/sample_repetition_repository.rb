
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

  def retrieve_statistics
    @statistics
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
