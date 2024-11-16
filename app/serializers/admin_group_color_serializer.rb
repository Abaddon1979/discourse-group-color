# plugins/discourse-group-color/serializers/admin_group_color_serializer.rb

module DiscourseGroupColor
  class AdminGroupColorSerializer < ::Admin::BasicGroupSerializer
    attributes :color, :rank
  end
end