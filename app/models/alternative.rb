class Alternative < ActiveRecord::Base
  has_and_belongs_to_many :alternatives_sets

end
