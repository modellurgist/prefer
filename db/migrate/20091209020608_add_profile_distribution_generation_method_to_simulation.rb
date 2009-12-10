class AddProfileDistributionGenerationMethodToSimulation < ActiveRecord::Migration
  def self.up
    add_column :simulations, :profile_distribution_generation_method, :string
  end

  def self.down
    remove_column :simulations, :profile_distribution_generation_method
  end
end
