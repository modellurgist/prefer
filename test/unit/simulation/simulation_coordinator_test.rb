
require 'test/test_helper'
require 'lib/prefer/simulation/simulation_coordinator'

class SimulationCoordinatorTest < Test::Unit::TestCase


  context "a new simulation coordinator" do
    context "initialized with no specification" do
      setup do
        @coordinator = SimulationCoordinator.new(@specification)
      end
      context "when a new election result record is added to the results" do
        setup do
          record = SimulationResultRecord.new
          sample_size = 2
          @coordinator.add_to_results_for_sample_size(record, sample_size)
        end
        context "and the coordinator results are examined" do
          setup do
            @results = @coordinator.results
          end 
          test "the object in results with a key 2 should not be a Hash" do
            object = @results.find_all_repetitions_for_size(2)
            assert_equal false, (object.class == Hash)
          end
          test "the object in results with a key 2 should be an Array" do
            object = @results.find_all_repetitions_for_size(2)
            assert_respond_to object, :pop
          end
          test "when the object in results at key 2 is accessed as an array at position 0" do
            object = @results.find_any_repetition_for_size(2)
            assert_equal object.class, SimulationResultRecord
          end

        end
      end
    end
  end

  context "a new simulation coordinator" do
    context "initialized with complete, valid specification for 3 alternatives, 10 citizens, step size 1, plurality vote" do
      setup do 
        parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :plurality, 
                      :sample_size_increment => 1, :repetitions => 1, :sample_size_minimum => 1, :sample_size_maximum => 9}
        @specification = SimulationSpecification.new(parameters)
        @coordinator = SimulationCoordinator.new(@specification)
      end
      context "when citizens are created for the simulation" do 
        setup do 
          @coordinator.create_citizens
        end
        test "should create at least one citizen with preferences over the alternatives" do
          example_citizen = @coordinator.citizens.first
          assert_includes_all_from(example_citizen.profile, @specification.alternatives)
        end
        test "should create the correct number of citizens" do 
          assert_equal 10, @coordinator.citizens.size
        end
        test "should collect all citizen profiles into one knowledge base" do
          assert_respond_to @coordinator.collected_profiles, :each
        end
      end
      context "when it receives the request to run_one_election_for_each_in_sample_size_range" do
        setup do
          @coordinator.run_multiple_elections_for_each_in_sample_size_range
          @results = @coordinator.results
        end
        test "should create the citizens" do 
          assert_equal 10, @coordinator.citizens.size
        end
        context "and the results are examined" do
          setup do
            @all_records = @results.find_all_repetitions_for_all_sizes
          end
          test "should hold at least one election with the full population" do
            result_full_sample = @results.retrieve_population_record
            assert_not_nil result_full_sample.election_record[:social_profile] 
          end
          test "should hold at least the election at the first increment past zero sample size" do
            result_first_sample = @results.find_any_repetition_for_size(1)
            assert_not_nil result_first_sample.election_record[:social_profile] 
          end
          test "should only hold the election for the fourth sample size among citizens that number exactly that size" do
            result_fourth_sample = @results.find_any_repetition_for_size(4)
            assert_equal 4, result_fourth_sample.election_record[:citizen_sample].size
          end
          test "each result's comparison records should not be nil" do
            assert @all_records.all? {|record| record.comparison_records != nil}
          end
          context "and it receives the request to perform sample comparisons" do
            setup do
              @coordinator.perform_simulation_analyses
            end
            test "each result's comparison records should not be empty" do
              assert @all_records.all? {|record| !record.comparison_records.empty?}
            end
            test "each result should have a vote percent comparison that is not nil" do
              assert @all_records.all? {|record| record.comparison_records.all? {|key,comparison| comparison != nil}}
            end
          end
        end
        context "when it is requested to export one analysis to csv for the winning alternative" do
          setup do
            @alternative = @results[10].winning_alternative
            #@vote_percent_csv = @coordinator.export_one_analysis_to_csv(:vote_percent, @alternative)
          end
          #test "alternative should be a string" do
          #  assert @alternative.is_a?(String)
          #end
          #test "the 10th result should be of class SimulationResultRecord" do
          #  assert @results[10].is_a?(SimulationResultRecord)
          #end
          #test "the csv text should have 10 lines" do
          #  assert_equal 10, @vote_percent_csv.count("\n")
          #end
        end
        context "and then is requested to export results" do
          test "should generate text file with correct csv" do
            # test live
          end
        end
      end
    end
    context "initialized with complete, valid specification for 3 alternatives, 1 citizens, step size 1, plurality vote" do
      setup do 
        parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :plurality, 
                      :sample_size_increment => 1, :repetitions => 1, :sample_size_minimum => 1, :sample_size_maximum => 9}
        @specification = SimulationSpecification.new(parameters)
        @coordinator = SimulationCoordinator.new(@specification)
      end
      test "the increment size should be 1" do
        assert_equal 1, @coordinator.increment_size
      end
      context "when citizens have been created and stored" do
        setup do
          @coordinator.create_citizens
          @coordinator.store_citizens
        end
        test "the selected sample should have size of 1" do
          assert_equal 1, @coordinator.select_sample(1).size
        end
      end
    end
  end

end
