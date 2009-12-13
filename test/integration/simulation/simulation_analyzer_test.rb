
require 'test/test_helper'

require 'lib/prefer/simulation/simulation_analyzer'
require 'lib/prefer/simulation/simulation_specification'

class SimulationAnalyzerTest < Test::Unit::TestCase

  context "given a simulation coordinator initialized with valid specifications for 10 citizens, 3 alternatives, plurality method, 10 repetitions, and increment size 1" do
    setup do
      parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :plurality, :sample_size_increment => 1,
                    :repetitions => 10, :sample_size_minimum => 1, :sample_size_maximum => 9, :distribution_type => :approximate_uniform}
      @specification = SimulationSpecification.new(parameters)
      @coordinator = SimulationCoordinator.new(@specification)
    end
    context "when the coordinator is run_multiple_election_for_each_in_sample_size_range, its results returned" do
      setup do
        @coordinator.run_multiple_elections_for_each_in_sample_size_range
        @results = @coordinator.results
      end
      test "the variance for the population winner vote percent in sample size 9 should be greater than zero" do
        population_winner = @results.retrieve_population_record.winning_alternative
        variance_in_sample = @results.find_statistic_for_sample_size(9, :variance, :vote_percent, population_winner)
        assert_block {variance_in_sample > 0}
      end
    end
  end

  context "given a simulation coordinator initialized with valid specifications for 10 citizens, 3 alternatives, plurality method, 1 repetition, and increment size 1" do
    setup do 
      parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :plurality, :sample_size_increment => 1, 
                    :repetitions => 1, :sample_size_minimum => 1, :sample_size_maximum => 9, :distribution_type => :approximate_uniform}
      @specification = SimulationSpecification.new(parameters)
      @coordinator = SimulationCoordinator.new(@specification)
    end
    context "when the coordinator is run_multiple_election_for_each_in_sample_size_range, its results returned" do
      setup do
        @coordinator.run_multiple_elections_for_each_in_sample_size_range
        @results = @coordinator.results
      end
      context "a valid record for full population is selected from the results" do
        setup do
          @record = @results.retrieve_population_record
          @population_winner = @record.winning_alternative
          @population_vote_percent_for_alternative = @record.analysis_records[:vote_percent][@population_winner]
        end
        test "population vote percent is not null" do
          assert_not_nil @population_vote_percent_for_alternative 
        end
        test "vote percent analysis for population sample should not be null" do        
          assert_not_nil @record.analysis_records[:vote_percent][@population_winner]
        end
      end

      context "a new analyzer initialized with the full set of results" do
        setup do
          @second_analyzer = SimulationAnalyzer.new(@results)
          @record = @results.retrieve_population_record
          @population_winner = @record.winning_alternative
        end
        test "the input results should not be null" do
          assert_not_nil @results
        end
        test "its records should not be null" do
          assert_not_nil @second_analyzer.results
        end
        test "its results should not be empty" do
          assert !@second_analyzer.results.empty?
        end
      end
    end
  end


end


