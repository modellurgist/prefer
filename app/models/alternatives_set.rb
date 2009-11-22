class AlternativesSet < ActiveRecord::Base
  has_many :simulations
  has_and_belongs_to_many :alternatives

  def new_alternative_attributes=(alternative_attributes)
    alternative_attributes.each do |attributes|
      alternative.build(attributes)
    end
  end

end
