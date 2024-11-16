# plugins/discourse-group-color/controllers/admin/group_colors_controller.rb

module DiscourseGroupColor
  class AdminGroupColorsController < ::Admin::AdminController
    requires_plugin 'discourse-group-color'

    def index
      groups = Group.order(:name)
      render_serialized(groups, AdminGroupColorSerializer)
    end

    def update
      group = Group.find(params[:id])
      group.assign_attributes(
        color: params.require(:group).permit(:color, :rank)
      )
      if group.save
        render json: success_json
      else
        render json: failed_json, status: 422
      end
    end
  end
end