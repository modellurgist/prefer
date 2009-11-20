class CreateAlternatives < ActiveRecord::Migration
  def self.up
    create_table :alternatives do |t|
      t.string :alternative

      t.timestamps
    end
  end

  def self.down
    drop_table :alternatives
  end
end
