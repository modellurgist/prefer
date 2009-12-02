
require 'lib/prefer/analysis/simulation/vote_percent_comparison_method'

class SimulationAnalysisFactory

  def build(method_name)
    self.send(method_name)
  end

  # private

  def compare_by_vote_percent
    VotePercentComparisonMethod.new
  end
  
  
  
end
