
require 'test/test_helper'
require 'lib/prefer/simulation/simulation_coordinator'

class SimulationCoordinatorTest < Test::Unit::TestCase

  context "a new simulation coordinator" do
    context "initialized with complete, valid specification for 3 alternatives, 10 citizens, step size 1, and IRV vote" do
      setup do 
        parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :irv, :sample_size_increment => 1, :repetitions => 1}
        @specification = SimulationSpecification.new(parameters)
        @coordinator = SimulationCoordinator.new(@specification)
      end
      context "when it receives the request to run a single repetition for each in the sample size range" do
        setup do
          @coordinator.run_one_election_for_each_in_sample_size_range
          @results = @coordinator.results
        end
        context "and the results are examined" do
          test "should hold at least one election with the full population" do
            result_full_sample = @results.retrieve_population_record
            assert_not_nil result_full_sample.election_record[:social_profile] 
          end
          context "and it receives the request to perform sample comparisons" do
            setup do
              @coordinator.perform_simulation_analyses
            end
            test "each result's comparison records should not be empty" do
              assert @results.find_all_repetitions_for_all_sizes.all? {|sample_size,record| !record.comparison_records.empty?}
            end
            test "each result should have a vote percent comparison that is not nil" do
              assert @results.find_all_repetitions_for_all_sizes.all? {|sample_size,record| record.comparison_records.all? {|key,comparison| comparison != nil}}
            end
          end
        end
      end
    end
  end

  context "a new simulation coordinator" do
    context "initialized with complete, valid specification for multiple elections for one sample size on 3 alternatives, 10 citizens, sample size 5, repetitions 3, and IRV vote" do
      setup do
        parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :irv, :sample_size => 5, :repetitions => 3}
        @specification = SimulationSpecification.new(parameters)
        @coordinator = SimulationCoordinator.new(@specification)
      end
      context "when it receives the request to run with multiple repetitions of same one sample size" do
        setup do
          @coordinator.run_multiple_elections_for_one_sample_size
          @results = @coordinator.results
        end
        context "and the results are examined" do
          test "there should be 3 records for sample size 5" do
            repetitions = @results.find_all_repetitions_for_size(5)
            assert_equal 3, repetitions.size
          end
        end
      end
    end
  end

end
