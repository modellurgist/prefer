
require 'lib/prefer/analysis/simulation/vote_percent_comparison_method'
require 'lib/prefer/analysis/simulation/sample_statistics_suite'

class SimulationAnalysisFactory

  def build(method_name)
    self.send(method_name)
  end

  # private

  def compare_by_vote_percent
    VotePercentComparisonMethod.new
  end
  
  def sample_statistics
    SampleStatisticsSuite.new
  end
  
  
end
