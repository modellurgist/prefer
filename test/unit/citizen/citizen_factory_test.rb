
require 'test/backend_test_helper'

class CitizenFactoryTest < Test::Unit::TestCase

  context "a citizen factory initialized with a collection of alternatives" do 
    setup do 
      @alternatives = ["Bush", "Nader", "Gore"]
      @factory = CitizenFactory.new(@alternatives)
      @citizen = @factory.build
      @population_100 = Array.new
      100.times {|i| @population_100 << @factory.build } 
    end
    test "should build a citizen that responds to a request for its profile" do
      assert_respond_to @citizen, :profile
    end
    test "should build a citizen that has a non empty profile" do
      assert @citizen.profile.size > 0
    end
    test "should build a citizen with a profile that differs from at least one other citizen" do
      differing_citizen = @population_100.find {|another| @citizen.profile != another.profile} 
      assert_not_equal @citizen.profile, differing_citizen.profile
    end
    context "to at least one citizen built" do
      setup do
        @p1 = ["Bush", "Nader", "Gore"]
        @p2 = ["Bush", "Gore", "Nader"]
        @p3 = ["Nader", "Bush", "Gore"]
        @p4 = ["Nader", "Gore", "Bush"]
        @p5 = ["Gore", "Bush", "Nader"]
        @p6 = ["Gore", "Nader", "Bush"]
      end
      test "should assign 1st profile" do
        assert_not_nil @population_100.find {|citizen| citizen.profile == @p1}
      end
      test "should assign 2nd profile" do
        assert_not_nil @population_100.find {|citizen| citizen.profile == @p2}
      end
      test "should assign 3rd profile" do
        assert_not_nil @population_100.find {|citizen| citizen.profile == @p3}
      end
      test "should assign 4th profile" do
        assert_not_nil @population_100.find {|citizen| citizen.profile == @p4}
      end
      test "should assign 5th profile" do
        assert_not_nil @population_100.find {|citizen| citizen.profile == @p5}
      end
      test "should assign 6th profile" do
        assert_not_nil @population_100.find {|citizen| citizen.profile == @p6}
      end
    end

  end

end
