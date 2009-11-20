
require 'test/backend_test_helper'
require 'lib/prefer/io/report_writer'

class ReportWriterTest < Test::Unit::TestCase

  context "a new report_writer with dummy initialization parameters" do
    setup do
      @provider.stubs(:specification).returns(nil)
      @writer = ReportWriter.new(@provider)
    end
    context "given a citizen profile with three alternatives" do
      setup do 
        @citizen = Citizen.new(["Nader","Gore","Bush"])
      end
      test "request for simple collection to csv line should display correct csv for given citizen profile" do
        assert_equal "Nader,Gore,Bush\n", @writer.simple_collection_to_csv_line(@citizen.profile)
      end
    end
  end

end
