
require 'test/backend_test_helper'
require 'lib/prefer/voting/voting_method_factory'

class VotingMethodFactoryTest < Test::Unit::TestCase

  context "a new voting method factory" do 
    setup do 
      @factory = VotingMethodFactory.new
    end
    test "should provide a voting method upon symbol-passed request that responds to run" do
      assert_respond_to @factory.build(:plurality), :run
    end
    test "should provide a voting method upon string-passed request that responds to run" do
      assert_respond_to @factory.build("plurality"), :run
    end
  end

end
