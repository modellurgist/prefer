
require 'test/test_helper'
require 'lib/prefer/analysis/sample/vote_percent_calculation'
require 'lib/prefer/simulation/simulation_result_record'

class VotePercentCalculationTest < Test::Unit::TestCase


  context "given three citizens with profiles over 3 alternatives" do
    setup do 
      @first_citizen = Citizen.new(["apple", "orange", "banana"])
      @second_citizen = Citizen.new(["apple", "banana", "orange"])
      @third_citizen = Citizen.new(["orange", "apple", "banana"])
    end
    context "when an plurality election is held among two of them" do
      setup do
        @sized_2_result = SimulationResultRecord.new
        @sized_2_result.record_election({:citizen_sample => [@first_citizen, @second_citizen], 
                                         :social_profile => ["apple"]})
        @calculation = VotePercentCalculation.new
        @calculation.run(@sized_2_result)
      end
      test "should calculate correct vote percent for apple" do
        assert_equal 100, @sized_2_result.analysis_records[:vote_percent]["apple"]   
      end
    end
    context "when a plurality election is held among all three" do
      setup do 
        @sized_3_result = SimulationResultRecord.new
        @sized_3_result.record_election({:citizen_sample => [@first_citizen, @second_citizen, @third_citizen], 
                                         :social_profile => ["apple"]})
        @calculation = VotePercentCalculation.new
        @calculation.run(@sized_3_result)
      end
      test "should calculate correct total supporter votes for apple" do
        assert_equal 2, @calculation.total_supporter_votes("apple", @sized_3_result.election_record[:citizen_sample]) 
      end
      test "should calculate correct vote percent for apple" do
        assert_equal 2.0/3*100, @sized_3_result.analysis_records[:vote_percent]["apple"]   
      end
    end
  end


end


