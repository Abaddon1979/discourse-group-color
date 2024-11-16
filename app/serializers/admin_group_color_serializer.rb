# plugins/discourse-group-color/app/serializers/admin_group_color_serializer.rb

module DiscourseGroupColor
  class AdminGroupColorSerializer < ::BasicGroupSerializer
    attributes :color, :rank

    def color
      object.color || ""
    end

    def rank
      object.rank || 9999
    end
  end
end