# To change this template, choose Tools | Templates
# and open the template in the editor.

class User < Principal
  has_many :notes, :class_name => 'Note'
  has_many :mynotes, :class_name => 'Note', :foreign_key => 'user_id', :conditions => "#{Note.table_name}.parent_id = 0 AND #{Note.table_name}.keep_a_copy = 1"
  has_many :sendtomenotes, :class_name => 'Note', :foreign_key => 'user_id', :conditions => "#{Note.table_name}.parent_id != 0 "

  named_scope :not_in_any_group, :conditions => "#{User.table_name}.status = #{STATUS_ACTIVE} AND #{User.table_name}.id NOT IN (SELECT user_id FROM groups_users)"

end

