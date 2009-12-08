
require 'test/test_helper'

class SampleRepetitionRepositoryTest < Test::Unit::TestCase

  context "a repetition repository and an empty record" do
    setup do
      @repository = SampleRepetitionRepository.new
      @record = SimulationResultRecord.new
    end
    test "should be able to find the exact record that was the only one previously stored" do
      @repository.store_repetition(@empty_record)
      assert_equal @empty_record.object_id, @repository.first_repetition.object_id
    end

  end

end
