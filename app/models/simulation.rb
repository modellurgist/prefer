class Simulation < ActiveRecord::Base
  belongs_to :alternatives_set

  def alternatives_set_name 
    self.alternatives_set.description
  end

end
