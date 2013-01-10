#-- encoding: UTF-8
# User landing page plugin for Chiliproject
# Copyright (C) 2011 Arnauld NYAKU

class UserPreference < ActiveRecord::Base
  has_one :user_landing_page, :dependent => :destroy, :class_name => 'NotePreference'

  def display_option
    d_option = NotePreference.find_by_user_id(user.id)
    return nil unless d_option
    d_option.display_option
  end

  def display_option=(display_option)
    d_option = NotePreference.find_or_create_by_user_id(user.id)
    d_option.display_option = display_option
    d_option.save!
  end

  def page_option
    p_option = NotePreference.find_by_user_id(user.id)
    return nil unless p_option
    p_option.page_option
  end

  def page_option=(page_option)
    p_option = NotePreference.find_or_create_by_user_id(user.id)
    p_option.page_option = page_option
    p_option.save!
  end

end
