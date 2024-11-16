# name: discourse-group-color
# about: Color usernames based on their groups
# version: 1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color

enabled_site_setting :discourse_group_color_enabled

register_asset "stylesheets/common/discourse-group-color.scss"
register_asset "stylesheets/desktop/user-card-hover.scss"

# Register JavaScript assets
register_asset 'javascripts/discourse/initializers/color-usernames.js.es6'
register_asset 'javascripts/discourse/initializers/user-card-hover.js.es6'
register_asset 'javascripts/discourse/routes/admin/group-colors.js.es6'
register_asset 'javascripts/discourse/controllers/admin/group-colors.js.es6'
register_asset 'javascripts/discourse/models/admin-group-color.js.es6'
register_asset 'javascripts/discourse/templates/admin/group-colors.hbs'

# Require the serializer
require File.expand_path('serializers/admin_group_color_serializer.rb', __dir__)

after_initialize do
  # Extend the Group model to include color and rank
  Group.register_attribute(:color, :string, default: '')
  Group.register_attribute(:rank, :integer, default: 9999)

  # Add color and rank attributes to the GroupSerializer
  add_to_serializer(:basic_group, :color) { object.color }
  add_to_serializer(:basic_group, :rank) { object.rank }

  # Add user's groups with color and rank to the user card serializer
  add_to_serializer(:user_card, :user_group_colors) do
    object.user.groups.map do |group|
      {
        name: group.name,
        color: group.color,
        rank: group.rank
      }
    end
  end

  # Load the admin controller
  load File.expand_path('controllers/admin/group_colors_controller.rb', __dir__)

  # Add routes for the admin group colors page
  Discourse::Application.routes.append do
    namespace :admin, constraints: AdminConstraint.new do
      get  '/groups/colors'     => 'group_colors#index',   as: 'admin_group_colors'
      put  '/groups/:id/colors' => 'group_colors#update',  as: 'admin_group_color_update'
    end
  end
end