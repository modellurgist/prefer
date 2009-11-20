
require 'test/backend_test_helper'
require 'lib/prefer/simulation/simulation_analyzer'

class SimulationAnalyzerTest < Test::Unit::TestCase

  context "a new simulation analyzer when initialized" do
    context "should throw null parameter" do 
      test "if missing a results collection" do
        assert_throws :null_parameter do
          SimulationAnalyzer.new(nil)
        end
      end
    end
  end

  context "when initialized with result records from 3 simulations " do
    setup do 
      @first_citizen = Citizen.new(["apple", "orange", "banana"])
      @second_citizen = Citizen.new(["apple", "banana", "orange"])
      @third_citizen = Citizen.new(["orange", "apple", "banana"])
      @sized_1_result = SimulationResultRecord.new
      @sized_1_result.record_election({:citizen_sample => [@third_citizen], 
                                       :social_profile => ["orange"]})
      @sized_1_result.record_analysis(:vote_percent, {"apple"=>0, "orange"=>100, "banana"=>0})
      @sized_2_result = SimulationResultRecord.new
      @sized_2_result.record_election({:citizen_sample => [@first_citizen, @second_citizen], 
                                       :social_profile => ["apple"]})
      @sized_2_result.record_analysis(:vote_percent, {"apple"=>100, "orange"=>0, "banana"=>0})
      @sized_3_result = SimulationResultRecord.new
      @sized_3_result.record_election({:citizen_sample => [@first_citizen, @second_citizen, @third_citizen], 
                                       :social_profile => ["apple"]})
      @sized_3_result.record_analysis(:vote_percent, {"apple"=>2.0/3*100, "orange"=>1.0/3*100, "banana"=>0})
      @results = {1 => @sized_1_result, 2 => @sized_2_result, 3 => @sized_3_result}
      @analyzer = SimulationAnalyzer.new(@results)
    end
    context "when compared by vote percent" do
      test "should calculate and store correct comparison result for third sample" do
        @analyzer.compare_by_vote_percent
        sample_record = @results[3]
        assert_equal 0, sample_record.comparison_records[:vote_percent]["apple"] 
      end
      test "should calculate and store correct comparison result for second sample" do
        @analyzer.compare_by_vote_percent
        sample_record = @results[2]
        assert_equal (100 - 2.0/3*100), sample_record.comparison_records[:vote_percent]["apple"] 
      end
      test "should calculate and store correct comparison result for first sample" do
        @analyzer.compare_by_vote_percent
        sample_record = @results[1]
        assert_equal (-2.0/3*100), sample_record.comparison_records[:vote_percent]["apple"] 
      end
    end
  end

  context "given a results set" do
    test "should determine correct size of full population" do
      results = {1 => {}, 2 => {}, 3 => {}}
      analyzer = SimulationAnalyzer.new(results)
      assert_equal 3, analyzer.full_population_size
    end
  end


end

