# To change this template, choose Tools | Templates
# and open the template in the editor.

class NotePreference < ActiveRecord::Base
  set_table_name 'post_it_notes_user_preferences'

  serialize :preferences, Array

  DISPLAY_POST_IT_OPTIONS = [
    ['all', :label_display_post_it_option_all],
    ['only_my_post_it', :label_display_only_my_post_it_option],
    ['only_post_it_send_to_me', :label_display_post_it_send_to_me_option],
  ]
  def self.display_post_it_options
    DISPLAY_POST_IT_OPTIONS
  end

  def self.find_or_create_by_user_id(user_id)
    user_preference = NotePreference.find(:first, :conditions => ["user_id = ?", user_id])
    unless user_preference
      user_preference = NotePreference.new
      user_preference.user_id = user_id
    end
    user_preference
  end

end
