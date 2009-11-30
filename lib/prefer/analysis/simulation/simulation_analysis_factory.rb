

class SimulationAnalysisFactory

  def build(method_name)
    self.send(method_name)
  end

  # private
  
  
  
end
