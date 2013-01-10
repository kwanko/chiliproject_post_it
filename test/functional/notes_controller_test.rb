# To change this template, choose Tools | Templates
# and open the template in the editor.

require File.expand_path('../../test_helper', __FILE__)
require 'notes_controller'

# Re-raise errors caught by the controller.
class NotesController; def rescue_action(e) raise e end; end

class NotesControllerTest < ActionController::TestCase
  fixtures :all

  def setup
    @controller = NotesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    User.current = nil
    @request.session[:user_id] = 1
  end
  
  def test_new
    get :new
    assert_response :success
    assert_template 'new'
  end
  
end
