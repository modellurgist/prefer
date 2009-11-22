class AlternativesSet < ActiveRecord::Base
  has_many :simulations
  has_and_belongs_to_many :alternatives

  def new_alternative_attributes=(alternative_attributes)
    alternative_attributes.each do |attributes|
      if attributes[:id].blank?
        alternatives.build(attributes)
      else 
        alternative = Alternative.find(attributes[:id].to_i)
        alternatives << alternative
        attributes.delete(:id)
      end
    end
  end

end
