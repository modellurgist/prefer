
require 'test/backend_test_helper'
require 'lib/prefer/simulation/simulation_analyzer'

class SimulationAnalyzerTest < Test::Unit::TestCase

  context "given a simulation coordinator initialized with valid specifications for 10 citizens, 3 alternatives, plurality method, and increment size 1" do
    setup do 
      parameters = {:alternatives => ["Bush","Gore","Nader"], :population_size => 10, :voting_method => :plurality, :sample_size_increment => 1} 
      @specification = SimulationSpecification.new(parameters)
      @coordinator = SimulationCoordinator.new(@specification)
    end
    context "when the coordinator is run, its results returned" do
      setup do
        @coordinator.run
        @results = @coordinator.results
      end
      context "a new analyzer initialized with a null set of results and a valid record for full population is selected from the results" do
        setup do
          @analyzer = SimulationAnalyzer.new({})
          @record= @results[10]
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
          @record= @results[10]
          @population_winner = @record.winning_alternative
          #@population_vote_percent_for_alternative = @record.analysis_records[:vote_percent][@alternative]
        end
        test "the input results should not be null" do
          assert_not_nil @results
        end
        test "its records should not be null" do
          assert_not_nil @second_analyzer.records
        end
        test "its records should not be empty" do
          assert !@second_analyzer.records.empty?
        end
        test "the sample vote percent for winning alternative should not be nil" do
          assert_not_nil @second_analyzer.sample_vote_percent_for(@record, @population_winner) 
        end
        test "the population vote percent for winning alternative should not be nil" do
          assert_not_nil @second_analyzer.population_vote_percent_for(@population_winner)
        end
        test "when the record is sent with a compare vote percent for sample message, it should calculate the sample deviation from the population's vote percent for the winner" do
          assert_equal 0, @second_analyzer.compare_vote_percent_for_sample(@record, @population_winner)
        end
        test "it should not raise an error when compare by vote percent is sent" do
          assert_nothing_raised {@second_analyzer.compare_by_vote_percent}
        end
        test "it should return correct vote percent for winner in full population sample" do
          assert(@second_analyzer.population_vote_percent_for(@population_winner) > 0)
        end
        #context "when compare by vote percent is called" do
        #  setup do
        #    @second_analyzer.compare_by_vote_percent
        #  end
        #  test "the input results should not be null" do
        #    assert_not_nil @results
        #  end
        #  test "the results for population sample should contain correct comparison for vote percent" do
        #    assert_equal 0, @record.comparison_records[:vote_percent][@population_winner] 
        #  end
        #  test "population vote percent is not null" do
        #    assert_not_nil @second_analyzer.population_vote_percent_for(@population_winner) 
        #  end
        #  test "vote percent analysis for population sample should not be null" do        
        #    assert_not_nil @record.analysis_records[:vote_percent][@population_winner]
        #  end
        #  test "when the record is sent with a compare vote percent for sample message, it should calculate the sample deviation from the population's vote percent for the winner" do
        #    #assert_equal 0, @analyzer.compare_vote_percent_for_sample(@record, @alternative)
        #  end
        #end
      end
    end
  end


end


