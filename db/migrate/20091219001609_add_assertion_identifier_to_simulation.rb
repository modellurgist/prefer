class AddAssertionIdentifierToSimulation < ActiveRecord::Migration
  def self.up
    add_column :simulations, :assertion_identifier, :string
  end

  def self.down
    remove_column :simulations, :assertion_identifier
  end
end
