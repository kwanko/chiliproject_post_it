# To change this template, choose Tools | Templates
# and open the template in the editor.

class CreatePostItNotes < ActiveRecord::Migration
  def self.up
    create_table :post_it_notes, :force => true do |t|
      t.column :title, :string, :null => false
      t.column :content, :text
      t.column :alert_start_datetime, :timestamp
      t.column :author_id, :integer, :null => false
      t.column :user_id, :integer, :default => 0, :null => false
      t.column :parent_id, :integer, :default => 0, :null => false

      t.column :created_on, :timestamp
      t.column :updated_on, :timestamp
    end
  end

  def self.down
    drop_table :post_it_notes
  end
end