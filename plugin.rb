# name: discourse-group-color
# about: Color usernames based on their groups
# version: 1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color

enabled_site_setting :discourse_group_color_enabled

register_asset 'stylesheets/common/discourse-group-color.scss'
register_asset 'stylesheets/desktop/user-card-hover.scss'

# Load necessary files
require_relative 'serializers/admin_group_color_serializer'
require_relative 'controllers/admin/group_colors_controller'

after_initialize do
  # Routes for admin page
  Discourse::Application.routes.append do
    namespace :admin, constraints: AdminConstraint.new do
      get '/groups/colors',       to: 'admin_group_colors#index', as: 'admin_group_colors'
      put '/groups/:id/colors',   to: 'admin_group_colors#update', as: 'admin_group_color_update'
    end
  end
  
  # Add serializer attributes
  add_to_serializer(:user_card, :user_group_colors) do
    object.groups.map do |group|
      { name:  group.name, color: group.color, rank: group.rank }
    end
  end
end