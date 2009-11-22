class AlternativesSet < ActiveRecord::Base
  has_many :simulations
  has_and_belongs_to_many :alternatives

end
