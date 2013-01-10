# To change this template, choose Tools | Templates
# and open the template in the editor.

class CreatePostItNotesUserPreferences < ActiveRecord::Migration
  class NotePrefenrence < ActiveRecord::Base; set_table_name 'post_it_notes_user_preferences' end
  def self.up
    create_table :post_it_notes_user_preferences, :force => true do |t|
      t.column :display_option, :string, :null => false, :default => 'all'
      t.column :page_option, :boolean, :null => false, :default => true
      t.column :user_id, :integer, :default => 0, :null => false

      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end

    User.active.collect { |u| NotePreference.create(:user_id => u.id) }
  end

  def self.down
    drop_table :post_it_notes_user_preferences
  end
end