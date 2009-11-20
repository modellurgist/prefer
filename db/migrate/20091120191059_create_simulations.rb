class CreateSimulations < ActiveRecord::Migration
  def self.up
    create_table :simulations do |t|
      t.integer :sample_size_increment
      t.integer :population_size
      t.string :voting_method
      t.string :mode

      t.timestamps
    end
  end

  def self.down
    drop_table :simulations
  end
end
