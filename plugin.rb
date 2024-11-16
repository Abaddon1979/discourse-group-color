# name: discourse-group-color
# about: Color usernames based on their groups
# version: 1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color

enabled_site_setting :discourse_group_color_enabled

register_asset 'stylesheets/common/discourse-group-color.scss'
register_asset 'stylesheets/desktop/user-card-hover.scss'

# Load required files
load File.expand_path('serializers/admin_group_color_serializer.rb', __dir__)
load File.expand_path('controllers/admin/group_colors_controller.rb', __dir__)

after_initialize do
  # Define routes for the admin group colors page
  Discourse::Application.routes.append do
    namespace :admin, constraints: AdminConstraint.new do
      get '/groups/colors'     => 'group_colors#index',   as: 'admin_group_colors'
      put '/groups/:id/colors' => 'group_colors#update',  as: 'admin_group_color_update'
    end
  end
  # Add color and rank attributes to the GroupSerializer
  add_to_serializer(:basic_group, :color) { object.color }
  add_to_serializer(:basic_group, :rank)  { object.rank }

  # Add user's groups with color and rank to the user card serializer
  add_to_serializer(:user_card, :user_group_colors) do
    object.groups.map do |group|
      {
        name:  group.name,
        color: group.color,
        rank:  group.rank
      }
    end
  end

  # Define routes for the admin group colors page
  Discourse::Application.routes.append do
    namespace :admin, constraints: AdminConstraint.new do
      get  '/groups/colors'       => 'group_colors#index',  as: 'admin_group_colors'
      put  '/groups/:id/colors'   => 'group_colors#update', as: 'admin_group_color_update'
    end
  end
end