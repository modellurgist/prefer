
require 'test/test_helper'
require 'lib/prefer/simulation/simulation_coordinator'

class SimulationCoordinatorTest < Test::Unit::TestCase

  context "a new simulation coordinator" do
    context "initialized with complete, valid specification for 3 alternatives, 10 citizens, step size 1, and IRV vote" do
      setup do 
        parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :irv, :sample_size_increment => 1, 
                      :repetitions => 1, :sample_size_minimum => 1, :sample_size_maximum => 9, :distribution_type => :approximate_uniform}
        @specification = SimulationSpecification.new(parameters)
        @coordinator = SimulationCoordinator.new(@specification)
      end
      context "when it receives the request to run a single repetition for each in the sample size range" do
        setup do
          @coordinator.run_multiple_elections_for_each_in_sample_size_range
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
            context "and all repetitions for all sizes are collected" do
              setup do
                @repetitions = @results.find_all_repetitions_for_all_sizes
              end
              test "each result's comparison records should not be empty" do
                assert @repetitions.all? {|record| !record.simulation_analysis_records.empty?}
              end
              test "each result should have a vote percent comparison that is not nil" do
                assert @repetitions.all? {|record| record.simulation_analysis_records.all? {|key,comparison| comparison != nil}}
              end
            end
          end
        end
      end
    end
  end

  context "a new simulation coordinator" do
    context "initialized with complete, valid specification for multiple elections for one sample size on 3 alternatives, 10 citizens, sample size 5, repetitions 3, and IRV vote" do
      setup do
        parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :irv,
                      :repetitions => 3, :sample_size => 5, :distribution_type => :approximate_uniform}
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
          test "there should be an election record for the first record for sample size 5" do
            repetition = @results.find_any_repetition_for_size(5)
            assert_not_nil repetition.election_record
          end
        end
      end
    end
  end

end
