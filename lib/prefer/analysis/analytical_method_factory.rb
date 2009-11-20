
require 'lib/prefer/analysis/sample/vote_percent_calculation'

class AnalyticalMethodFactory

  def build(method_name)
    self.send(method_name)
  end

  # private
  
  def vote_percent
    VotePercentCalculation.new
  end
  
  
end
