# To change this template, choose Tools | Templates
# and open the template in the editor.

class ChangePageOptionColumnToPostItNotesUserPreferences < ActiveRecord::Migration
  def self.up
    change_column :post_it_notes_user_preferences, :page_option, :boolean, :null => false, :default => false
  end

  def self.down
    change_column :post_it_notes_user_preferences, :page_option, :boolean, :null => false, :default => true
  end
end