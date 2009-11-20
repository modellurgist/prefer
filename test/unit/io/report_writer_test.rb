
require 'test/test_helper'
require 'lib/prefer/io/report_writer'

class ReportWriterTest < Test::Unit::TestCase

  context "a new report writer is initialized with a sufficiently descriptive simulation specification" do 
    setup do 
      specification = stub(:alternatives => ["apple","orange","banana"], 
                           :voting_method => "plurality", 
                           :population_size => 100,
                           :sample_size_increment => 5)
      @specification_provider.stubs(:specification).returns(specification)
      @report_writer = ReportWriter.new(@specification_provider)
    end
    test "should produce filename that is correct up to its timestamp, based on specifications" do
      assert @report_writer.build_filename =~ /plurality-vote__3-alternatives__100-unconnected-citizens__uniformly-distributed-profiles__sampled-mod-5__/ 
    end
    test "should produce filename that has correct extension" do
      assert @report_writer.build_filename =~ /.csv/ 
    end
  end

  context "a new report_writer with dummy initialization parameters" do
    setup do
      @provider.stubs(:specification).returns(nil)
      @writer = ReportWriter.new(@provider)
    end
    context "given a citizen profile with two alternatives" do
      setup do 
        @profile_1 = ["Bush","Nader"]
      end
      test "request for simple collection to csv line should display correct csv for given citizen profile" do
        assert_equal "Bush,Nader\n", @writer.simple_collection_to_csv_line(@profile_1)
      end
    end
    context "given a citizen profile with three alternatives" do
      setup do 
        @profile_2 = ["Bush","Gore","Nader"]
      end
      test "request for simple collection to csv line should display correct csv for given citizen profile" do
        assert_equal "Bush,Gore,Nader\n", @writer.simple_collection_to_csv_line(@profile_2)
      end
    end
  end

end
