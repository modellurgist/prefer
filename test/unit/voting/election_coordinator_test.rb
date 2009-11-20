
require 'test/backend_test_helper'
require 'lib/prefer/voting/election_coordinator'

class ElectionCoordinatorTest < Test::Unit::TestCase

  context "an election coordinator provided with a non empty citizen sample and the plurality voting method" do 
    setup do 
      alternatives = ["Bush","Gore","Nader"]
      @citizen_repository = CitizenRepository.new
      2.times { @citizen_repository.store(Citizen.new(alternatives)) }
      3.times { @citizen_repository.store(Citizen.new(alternatives.reverse)) }
      @citizen_sample = @citizen_repository.sample(5) 
      voting_method_factory = VotingMethodFactory.new
      @election_coordinator = ElectionCoordinator.new(@citizen_sample, :plurality)
    end
    test "should return the correct winner as the social profile" do
      assert_equal "Nader", @election_coordinator.aggregate_preferences.first
    end
    context "provided a sufficient result record and requested to report analysis" do
      setup do
        @record = SimulationResultRecord.new
        @record.record_election({:citizen_sample => @citizen_sample,
                                 :social_profile => ["Nader"]})
        @election_coordinator.report_analysis(@record)
      end
      test "should run the vote percent analysis and store results in the result record" do
        assert_equal 3.0/5*100, @record.analysis_records[:vote_percent]["Nader"]  
      end
    end
  end

end
