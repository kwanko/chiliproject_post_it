# To change this template, choose Tools | Templates
# and open the template in the editor.

class Note < ActiveRecord::Base
  
  
  set_table_name 'post_it_notes'

  belongs_to :author, :class_name => "User", :foreign_key => "author_id"

  
  validates_presence_of :title, :allow_blank => false
  validate :validate_alert_start_datetime

  after_destroy :update_children

# Récupérer les utilisateurs en partage d'une note
  def recipients
    User.find(:all, :conditions => " id IN (SELECT user_id FROM #{Note.table_name} WHERE parent_id = #{id})")
  end

# Détecter s'il y a un changement entre deux notes
  def has_changed?(note)
    title != note.title || content != note.content
  end

# Récupérer les notes filles
 def children
   Note.find(:all, :conditions => [" ? = parent_id", id])
 end

# S'il existe des enfants
 def has_children?
   children.any?
 end

# récupérer le parent de la note
 def parent
   parent? ? nil : Note.find(parent_id)
 end

# Si la note est une note parente
 def parent?
   parent_id.zero? && has_children?
 end

# Si la note est une note fille
 def child?
   !parent_id.zero?
 end

 private
 # Valider la datetime de manifestation de l'alerte
  def validate_alert_start_datetime
    errors.add(:alert_start_datetime, :invalid) if alert_start_datetime and alert_start_datetime <= DateTime.now
  end
  
  # Mettre à jour les notes liées à la note supprimée
  def update_children
    children.each {|n| n.update_attribute(:parent_id, 0) } if has_children?
  end
end
