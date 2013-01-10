# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddKeepACopyColumnToPostItNotes < ActiveRecord::Migration
  def self.up
    add_column :post_it_notes, :keep_a_copy, :boolean, :default => true
  end

  def self.down
    remove_column :post_it_notes, :keep_a_copy
  end
end