# Post it plugin for Chiliproject
# Copyright (C) 2012  C2B NETAFFILIATION  SA
# Author:  Arnauld NYAKU

require 'gravatar'
require_dependency 'application_helper'

module PostItNotesApplicationHelperPatch
  def self.included(base)
    base.class_eval do
      def postitnote_authoring(created, author)
        text = distance_of_time_in_words(Time.now, created)
        l(:label_note_added_time_by, :author => author, :age => content_tag('acronym', text, :title => format_time(created)))
      end

      def postitnote_recipients(note)
        s = ""
        return unless note.child? || note.parent?
        recipients = []
        if note.author.id == User.current.id
          recipients = note.recipients.collect(&:name)
        elsif !note.parent.nil?
          recipients = note.parent.recipients.keep_if {|r| r.id != User.current.id}.collect(&:name)
        end
        
        if recipients.any?
          s << "<strong>" + l(:text_send_to) + "</strong>"
          s << "<ul>"
          for recipient in recipients
            s << content_tag(:li, recipient.to_s)
          end
          s << "</ul>"
        end
        s
      end
    end
  end

end

ApplicationHelper.send(:include, PostItNotesApplicationHelperPatch)