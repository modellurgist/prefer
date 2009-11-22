class AddAssociationToSimulation < ActiveRecord::Migration
  def self.up
    add_column :simulations, :alternatives_set_id, :integer
  end

  def self.down
    remove_column :simulations, :alternatives_set_id
  end
end
