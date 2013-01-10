# To change this template, choose Tools | Templates
# and open the template in the editor.

class AddOldTitleAndContentColumnToPostItNotes < ActiveRecord::Migration
  def self.up
    add_column :post_it_notes, :old_title, :string
    add_column :post_it_notes, :old_content, :text
  end

  def self.down
    remove_column :post_it_notes, :old_title
    remove_column :post_it_notes, :old_content
    remove_column :post_it_notes, :old_author_id
  end
end