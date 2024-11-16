# name: discourse-group-color
# about: Color usernames based on their groups
# version: 1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color

enabled_site_setting :discourse_group_color_enabled

register_asset 'stylesheets/common/discourse-group-color.scss'
register_asset 'stylesheets/desktop/user-card-hover.scss'

after_initialize do
  module ::DiscourseGroupColor
    class Engine < ::Rails::Engine
      engine_name "discourse_group_color"
      isolate_namespace DiscourseGroupColor
    end
  end

  require_dependency "application_controller"
  require_dependency "basic_group_serializer"
  
  # Load serializer and controller
  load File.expand_path('../app/serializers/admin_group_color_serializer.rb', __FILE__)
  load File.expand_path('../app/controllers/admin/group_colors_controller.rb', __FILE__)

  # Routes for admin page
  Discourse::Application.routes.append do
    namespace :admin, constraints: StaffConstraint.new do
      get '/groups/colors' => 'discourse_group_color/admin_group_colors#index'
      put '/groups/:id/colors' => 'discourse_group_color/admin_group_colors#update'
    end
  end
  
  # Add serializer attributes
  add_to_serializer(:user_card, :user_group_colors) do
    object.groups.map do |group|
      { 
        name: group.name, 
        color: group.color, 
        rank: group.rank 
      }
    end
  end
end