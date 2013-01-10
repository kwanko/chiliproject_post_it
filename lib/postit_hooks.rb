# Post it plugin for Chiliproject
# Copyright (C) 2012  Arnauld NYAKU

class PostItHooks < Redmine::Hook::ViewListener
  def view_layouts_base_html_head(context = {})
    css = stylesheet_link_tag 'postit', :plugin => "chiliproject_post_it"
    css += stylesheet_link_tag 'jquery.ui.timepicker.addon.css', :plugin => "chiliproject_post_it"
    js = javascript_include_tag 'postit', :plugin => "chiliproject_post_it"
    js += javascript_include_tag 'jquery.ui.timepicker.addon.js', :plugin => "chiliproject_post_it"
    js += javascript_include_tag 'jquery.titlealert.js', :plugin => "chiliproject_post_it"
    js += javascript_include_tag 'jquery.qtip.js', :plugin => "chiliproject_post_it"
    css + js
  end
  render_on :view_layouts_base_header_top_menu, :partial => 'hooks/post_it/base_patch'
  render_on :view_layouts_base_content, :partial => 'hooks/post_it/postits_content_patch'
  render_on :view_my_account, :partial => 'hooks/my/post_it_form', :multipart => true
end
