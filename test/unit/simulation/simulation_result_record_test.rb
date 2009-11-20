
require 'test/test_helper'
require 'lib/prefer/simulation/simulation_result_record'

class SimulationResultRecordTest < Test::Unit::TestCase

  context "a new record" do
    setup do
      @new_record = SimulationResultRecord.new
    end
    context "when a comparison record is stored in the record" do
      setup do
        @new_record.record_comparison(:vote_percent, "apple", -20)
      end
      test "its comparison records should not be empty" do
        assert !@new_record.comparison_records.empty? 
      end
      test "its comparison records should contain an entry for the given analysis symbol" do
        assert_not_nil @new_record.comparison_records[:vote_percent]
      end
      test "should be able to retrieve that comparison record" do
        assert_equal -20, @new_record.comparison_records[:vote_percent]["apple"]
      end
    end
  end

  context "a full record after its simulation is complete" do
    setup do
      @record = SimulationResultRecord.new  
      specifications = {:alternatives => ["apple","orange","banana"], 
                        :population_size => 3, :voting_method => :plurality, 
                        :sample_size_increment => 1} 
      @record.specifications = specifications
      election_record = {:social_profile => ["apple"],
                         :citizen_sample => [Citizen.new(["apple","orange","banana"]),
                                             Citizen.new(["orange","apple","banana"])]}
      @record.record_election(election_record)
      @record.record_analysis(:vote_percent, {"apple"=>1.0/2*100, "orange"=>1.0/3*100, "banana"=>0}) 
      @record.record_comparison(:vote_percent, "apple", (-1.0/6*100))    
    end
    test "request for comparison to csv should send csv string for one alternative's deviation from the population value for one analysis method" do
      report_csv = <<TEXT
2,-16.6666666666667
TEXT
      assert_equal report_csv, @record.comparison_to_csv(:vote_percent,"apple")
    end
    test "request for available analyses returns correct collection" do
      assert_equal [:vote_percent], @record.available_comparisons
    end
  end

end
