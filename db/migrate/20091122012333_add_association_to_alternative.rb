class AddAssociationToAlternative < ActiveRecord::Migration
  def self.up
    add_column :alternatives, :alternatives_set_id, :integer
  end

  def self.down
    remove_column :alternatives, :alternatives_set_id
  end
end
