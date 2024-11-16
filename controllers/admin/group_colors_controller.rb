# plugins/discourse-group-color/controllers/admin/group_colors_controller.rb

module DiscourseGroupColor
  class AdminGroupColorsController < ::Admin::AdminController
    requires_plugin 'discourse-group-color'

    def index
      groups = ::Group.order(:name)
      render_serialized(groups, ::DiscourseGroupColor::AdminGroupColorSerializer)
    end

    def update
      group = ::Group.find(params[:id])
      
      if group.update(group_params)
        render json: success_json
      else
        render json: failed_json.merge(errors: group.errors.full_messages), status: 422
      end
    end

    private

    def group_params
      params.require(:group).permit(:color, :rank)
    end
  end
end