
require 'test/test_helper'

class SampleRepositoryTest < Test::Unit::TestCase

  context "a sample repository and an empty result record" do
    setup do
      @repository = SampleRepository.new 
      @empty_record = SimulationResultRecord.new
    end 
    context "when the empty record is stored for a sample size of 10" do
      setup do
        @repository.store_repetition_for_size(@empty_record, 10)
      end
      test "the repository should contain 1 repetition repository" do
        assert_equal 1, @repository.sample_count
      end
      test "when that repetition repository is accessed, it should have 1 record" do
        repetition_repo = @repository.retrieve_repetition_repository(10)
        assert_equal 1, repetition_repo.repetition_count
      end
      test "the repository should find a record that responds to specifications when receives a repetition for size 10" do
        repetition_repo = @repository.retrieve_repetition_repository(10)
        record = repetition_repo.first_repetition
        assert_respond_to record, :specifications
      end
      test "the repository should find a record that responds to specifications as the only repetition for size 10" do
        record = @repository.find_any_repetition_for_size(10)
        assert_respond_to record, :specifications
      end
      test "the repository should find an equivalent to that record as the only repetition for size 10" do
        assert_equal @empty_record.class, @repository.find_any_repetition_for_size(10).class
        assert_equal @empty_record.object_id, @repository.find_any_repetition_for_size(10).object_id
      end
    end

  end

end
