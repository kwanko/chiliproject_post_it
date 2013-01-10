# To change this template, choose Tools | Templates
# and open the template in the editor.
require File.expand_path('../../test_helper', __FILE__)

class NoteTest < ActiveSupport::TestCase
  fixtures :users, :notes

  def valid_note
    { :title => 'Test note', :description => 'This is a note etc', :author => User.find(:first) }
  end


  def setup
    super
  end

end
