class AddProfileDistributionGenerationMethodToSimulation < ActiveRecord::Migration
  def self.up
    add_column :simulations, :distribution_type, :string
  end

  def self.down
    remove_column :simulations, :distribution_type
  end
end
