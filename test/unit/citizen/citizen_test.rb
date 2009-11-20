
require 'test/test_helper'
require 'lib/prefer/citizen/citizen'

class CitizenTest < Test::Unit::TestCase

  context "a citizen instantiated with a valid profile" do 
    setup do 
      @profile = ["Bush","Gore","Nader"]
      @citizen = Citizen.new(@profile)
    end
    test "should be able to return that profile" do
      assert_equal @profile, @citizen.profile 
    end
  end

  context "a citizen instantiated with a non collection as its profile" do
    setup do
      @profile = 1 
    end
    test "should throw invalid profile" do
      assert_throws :invalid_profile do
        @citizen = Citizen.new(@profile)
      end
    end
  end

end
