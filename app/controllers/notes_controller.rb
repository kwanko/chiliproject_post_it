# To change this template, choose Tools | Templates
# and open the template in the editor.

class NotesController < ApplicationController
  unloadable

  layout false

  def index
    find_notes
    respond_to do |format|
      format.js
    end
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(params[:note].merge({:author_id => User.current.id, :user_id => User.current.id}))
    recipients = params[:send_to] ? params[:send_to] : []
   
    respond_to do |format|
     if @note.save
       recipients.uniq.each {|recipient| Note.create(params[:note].merge({:author_id => User.current.id, :user_id => recipient.to_i, :parent_id => @note.id, :keep_a_copy => true}))} if recipients.any?
       find_notes
       @notice = l(:notice_successful_create)
     else
       @notice = @note.errors.full_messages.collect{|message| message}.join(" \n ")
     end
     format.js
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    recipients = params[:send_to] ? params[:send_to] : []

    recipients.push(params[:send_a_copy_to_author]) if params[:send_a_copy_to_author] && !recipients.include?(params[:send_a_copy_to_author])

    old_note = params[:send_a_copy_to_author] ? Note.find(params[:id]).dup : Note.new

    respond_to do |format|
      if @note.update_attributes(params[:note])
        recipients.uniq.each do |recipient|
          Note.create(params[:note].merge({:author_id => User.current.id, :user_id => recipient.to_i, :parent_id => @note.id, :old_title => old_note.title, :old_content => old_note.content, :old_author_id => old_note.author_id})) unless Note.find(:all, :conditions => [" ? = author_id AND ? = user_id AND ? = parent_id", User.current.id, recipient.to_i, @note.id]).any?
        end if recipients.any?

        find_notes
        @notice = l(:notice_successful_update)
      else
        @notice = @note.errors.full_messages.collect{|message| message}.join(" \n ")
      end
      format.js
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    respond_to do |format|
      find_notes
      @notice = l(:notice_successful_delete)
      format.js
    end
  end
  
  def preview
    @content = (params[:note] ? params[:note][:content] : nil)
    render :partial => "preview"
  end

  def runalert
    notes_ids = params[:ids] ? params[:ids] : []
    old_notes = notes_ids.uniq.any? ? Note.find(:all, :conditions => ["id IN (?)", notes_ids.uniq]) : []
    find_notes
    @new_notes = @notes - old_notes
    respond_to do |format|
      format.js
    end
  end

  def setreminder
    @note = Note.find(params[:id])
    case params[:reminder_unity]
    when 'hour'
      @note.update_attribute(:alert_start_datetime, @note.alert_start_datetime + params[:reminder_value].to_i.hour)
    when 'day'
      @note.update_attribute(:alert_start_datetime, @note.alert_start_datetime + params[:reminder_value].to_i.day)
    when 'week'
      @note.update_attribute(:alert_start_datetime, @note.alert_start_datetime + params[:reminder_value].to_i.week)
    when 'month'
      @note.update_attribute(:alert_start_datetime, @note.alert_start_datetime + params[:reminder_value].to_i.month)
    else
    end
    
    respond_to do |format|
      format.js
    end
  end

 # Mettre à jouer left et top dans la BD après un drag on drop
  def update_positions
      if params[:id]
        pleft = params[:left] ? params[:left] : 0
        ptop = params[:top] ? params[:top] : 0
        ActiveRecord::Base.connection.execute("UPDATE post_it_notes SET left_position = #{pleft}, top_position = #{ptop} WHERE id = #{params[:id]}")
      end
  end
private
  def find_notes
    @notes = User.current.notes
  end

end