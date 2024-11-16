# plugins/discourse-group-color/serializers/admin_group_color_serializer.rb

module ::DiscourseGroupColor
  class AdminGroupColorSerializer < ::ApplicationSerializer
    attributes :id, :name, :color, :rank
  end
end