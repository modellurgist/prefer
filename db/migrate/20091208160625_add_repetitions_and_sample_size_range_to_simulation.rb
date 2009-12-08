class AddRepetitionsAndSampleSizeRangeToSimulation < ActiveRecord::Migration
  def self.up
    add_column :simulations, :repetitions, :integer
    add_column :simulations, :sample_size_minimum, :integer
    add_column :simulations, :sample_size_maximum, :integer
  end

  def self.down
    remove_column :simulations, :sample_size_maximum
    remove_column :simulations, :sample_size_minimum
    remove_column :simulations, :repetitions
  end
end
