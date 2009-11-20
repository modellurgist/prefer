
require 'test/backend_test_helper'
require 'lib/prefer/simulation/simulation_coordinator'

class SimulationCoordinatorTest < Test::Unit::TestCase

  context "a new simulation coordinator" do
    context "initialized with complete, valid specification for 3 alternatives, 10 citizens, step size 1, and IRV vote" do
      setup do 
        parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :irv, :sample_size_increment => 1} 
        @specification = SimulationSpecification.new(parameters)
        @coordinator = SimulationCoordinator.new(@specification)
      end
      context "when it receives the request to run" do
        setup do
          @coordinator.run
          @results = @coordinator.results
        end
        context "and the results are examined" do
          test "should hold at least one election with the full population" do
            result_full_sample = @results[10]
            assert_not_nil result_full_sample.election_record[:social_profile] 
          end
          context "and it receives the request to perform sample comparisons" do
            setup do
              @coordinator.perform_sample_comparisons
            end
            test "each result's comparison records should not be empty" do
              assert @results.all? {|sample_size,record| !record.comparison_records.empty?}
            end
            test "each result should have a vote percent comparison that is not nil" do
              assert @results.all? {|sample_size,record| record.comparison_records.all? {|key,comparison| comparison != nil}} 
            end
          end
        end
      end
    end
  end

end
