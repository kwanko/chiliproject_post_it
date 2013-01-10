# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddPositionColumnToPostItNotes < ActiveRecord::Migration
  def self.up
    add_column :post_it_notes, :left_position, :integer, :default => 0, :null => false
    add_column :post_it_notes, :top_position, :integer, :default => 0, :null => false
  end

  def self.down
    remove_column :post_it_notes, :left_position
    remove_column :post_it_notes, :top_possition
  end
end
