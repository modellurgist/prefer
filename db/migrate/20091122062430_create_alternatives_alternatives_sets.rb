class CreateAlternativesAlternativesSets < ActiveRecord::Migration
  def self.up
    create_table :alternatives_alternatives_sets do |t|
      t.integer :alternative_id
      t.integer :alternative_set_id
      t.timestamps
    end
  end

  def self.down
    drop_table :alternatives_alternatives_sets
  end
end
