
require 'test/test_helper'
require 'lib/prefer/voting/plurality_method'

class PluralityMethodTest < Test::Unit::TestCase

  context "a new plurality method" do 
    setup do 
      @method = PluralityMethod.new
    end
    test "should provide a voting method upon request that responds to run" do
      assert_respond_to @method, :run
    end
  end

end
