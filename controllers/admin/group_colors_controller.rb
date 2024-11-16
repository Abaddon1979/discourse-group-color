# plugins/discourse-group-color/controllers/admin/group_colors_controller.rb

module ::DiscourseGroupColor
  module Admin
    class GroupColorsController < ::Admin::AdminController
      requires_plugin ::DiscourseGroupColor

      def index
        groups = Group.order(:name)
        render_serialized(groups, ::DiscourseGroupColor::AdminGroupColorSerializer)
      end

      def update
        group = Group.find(params[:id])
        group.assign_attributes(
          color: params[:color],
          rank: params[:rank].to_i
        )
        if group.save
          render json: success_json
        else
          render json: failed_json, status: 422
        end
      end
    end
  end
end