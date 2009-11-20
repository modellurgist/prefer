
require 'test/test_helper'

class IrvMethodTest < Test::Unit::TestCase

  context "a new irv method in nonlogic mode" do 
    setup do 
      @method = IrvMethod.new
    end
    test "should pass the large test in the rubyvote library" do
      vote_array = Array.new
      42.times {vote_array << "ABCD".split("")}
      26.times {vote_array << "ACBD".split("")}
      15.times {vote_array << "BACD".split("")}
      32.times {vote_array << "BCAD".split("")}
      14.times {vote_array << "CABD".split("")}
      49.times {vote_array << "CBAD".split("")}
      17.times {vote_array << "ABDC".split("")}
      23.times {vote_array << "BADC".split("")}
      37.times {vote_array << "BCDA".split("")}
      11.times {vote_array << "CADB".split("")}
      16.times {vote_array << "CBDA".split("")}
      54.times {vote_array << "ADBC".split("")}
      36.times {vote_array << "BDCA".split("")}
      42.times {vote_array << "CDAB".split("")}
      13.times {vote_array << "CDBA".split("")}
      51.times {vote_array << "DABC".split("")}
      33.times {vote_array << "DBCA".split("")}
      39.times {vote_array << "DCAB".split("")}
      12.times {vote_array << "DCBA".split("")}
      citizens = Array.new
      vote_array.size.times {|i| citizens << Citizen.new(vote_array.fetch(i))} 
      assert_not_nil @method.run(citizens)
      assert_equal "C", @method.run(citizens)[0]
    end
  end

end
