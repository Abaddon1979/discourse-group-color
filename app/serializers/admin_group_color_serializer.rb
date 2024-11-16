# plugins/discourse-group-color/app/serializers/admin_group_color_serializer.rb

module DiscourseGroupColor
  class AdminGroupColorSerializer < ::BasicGroupSerializer
    attributes :color, :rank
  end
end