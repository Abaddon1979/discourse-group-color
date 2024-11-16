# plugins/discourse-group-color/serializers/admin_group_color_serializer.rb

class AdminGroupColorSerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :rank
end