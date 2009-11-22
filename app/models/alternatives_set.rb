class AlternativesSet < ActiveRecord::Base
  has_many :simulations
  has_and_belongs_to_many :alternatives

  def new_alternative_attributes=(alternative_attributes)
    alternative_attributes.each do |attributes|
      if attributes[:id].blank?
        alternatives.build(attributes)
      else # precondition: alternatives is not nil  && attributes[:id] is not blank
           #               attributes[:id] is an integer encoded as a character string
        #alternative = alternatives.find {|t| t.id == attributes[:id].to_i}
        alternative = Alternative.find(attributes[:id].to_i)
        alternatives << alternative
        #alternative.id = attributes[:id]
        attributes.delete(:id)
      end
    end
  end

end
