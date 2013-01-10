ActionController::Routing::Routes.draw do |map|
  map.connect 'notes', :controller => "notes", :action => "index"
  map.connect 'notes/new', :controller => "notes", :action => "new"
  map.connect 'notes/create', :controller => "notes", :action => "create"
  map.connect 'notes/preview', :controller => "notes", :action => "preview"
end


