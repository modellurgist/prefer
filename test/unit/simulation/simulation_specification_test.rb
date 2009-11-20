
require 'test/test_helper'
require 'lib/prefer/simulation/simulation_specification'

class SimulationSpecificationTest < Test::Unit::TestCase

  context "a request to instantiate a new specification" do
    setup do
      @alternatives = ["apple", "orange"]
      @population_size = 100
      @sample_size_increment = 10
      @increment_type = :absolute
      @voting_method = :plurality
      @parameters = { :alternatives => @alternatives, :population_size => @population_size,
                      :sample_size_increment => @sample_size_increment, :increment_type => @increment_type,
                      :voting_method => @voting_method }
    end
    context "should cause null parameter throw" do
      test "if missing a collection of alternatives" do
        @parameters.update({:alternatives => nil})
        assert_throws :null_parameter do
          new_specification 
        end
      end
      test "if missing a population size" do
        @parameters.update({:population_size => nil})
        assert_throws :null_parameter do
          new_specification 
        end
      end
      test "if missing a sample size increment" do
        @parameters.update({:sample_size_increment => nil})
        assert_throws :null_parameter do
          new_specification 
        end
      end
      #test "if missing an increment type" do
      #  @parameters.update({:increment_type => nil})
      #  assert_throws :null_parameter do
      #    new_specification 
      #  end
      #end
      test "if missing a voting method" do
        @parameters.update({:voting_method => nil})
        assert_throws :null_parameter do
          new_specification 
        end
      end
    end
  end

  def new_specification
    SimulationSpecification.new(@parameters)
  end

end
