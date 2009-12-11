
require 'test_helper'
require 'lib/prefer/statistics/sample_statistics_analyzer'

class SampleStatisticsAnalyzerTest < Test::Unit::TestCase

  context "a new SampleStatistics object and a sample of real values" do
    setup do
      @statistics = SampleStatisticsAnalyzer.new
      @sample = [0.3, 0.25, 0.35, 0.32, 0.31, 0.2]
    end
    test "should provide the correct variance" do
      assert_in_delta 0.0031, @statistics.sample_variance_given_population_mean(@sample, 0.3), 0.01
    end
  end
end
