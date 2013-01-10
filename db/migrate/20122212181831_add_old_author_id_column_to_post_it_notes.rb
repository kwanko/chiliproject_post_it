# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddOldAuthorIdColumnToPostItNotes < ActiveRecord::Migration
  def self.up
    add_column :post_it_notes, :old_author_id, :integer, :default => 0
  end

  def self.down
    remove_column :post_it_notes, :old_author_id
  end
end