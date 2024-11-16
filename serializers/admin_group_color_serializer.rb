# plugins/discourse-group-color/serializers/admin_group_color_serializer.rb

class ::AdminGroupColorSerializer < ::ApplicationSerializer
  attributes :id, :name, :color, :rank
end