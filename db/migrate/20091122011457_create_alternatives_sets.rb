class CreateAlternativesSets < ActiveRecord::Migration
  def self.up
    create_table :alternatives_sets do |t|
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :alternatives_sets
  end
end
