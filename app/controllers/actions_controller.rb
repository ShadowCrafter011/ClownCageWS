class ActionsController < ApplicationController
  before_action :require_login!
  layout false, only: :frame

  def dispatch_action
    callback_uuid = Action.find(params[:action_id]).dispatch(params[:uuid])

    if callback_uuid.present?
      redirect_to action_frame_path(params[:uuid], params[:action_id], state: "dispatched", callback_uuid: callback_uuid)
    else
      redirect_to action_frame_path(params[:uuid], params[:action_id])
    end
  end

  def action_status
    dispatch = Dispatch.find(params[:callback_uuid])
    render json: { success: true, name: dispatch.name, executed: dispatch.executed, error: dispatch.error }
  end

  def frame
    @action = Action.find params[:action_id]
    @enabled = @action.enabled? params[:uuid]

    @dispatch_button_name = params[:state] == "dispatched" ? "Sent" : "Dispatch"
    @dispatch_data = {
      turbo_method: :post,
      controller: "tippy",
      tippy_content: "Dispatch action with consumer data or default data",
      tippy_placement: "bottom"
    }

    if params[:state] == "dispatched"
      @dispatch_data[:controller] = "tippy action-status"
      @dispatch_data[:callback_uuid] = params[:callback_uuid]
    end
  end

  def toggle
    action_datum = ActionDatum::find_or_create_by(consumer_id: params[:uuid], action_id: params[:action_id])
    return unless action_datum.action.plugin?
    action_datum.toggle
    redirect_to action_frame_path(params[:uuid], params[:action_id])
  end

  def edit
    @action_datum = ActionDatum::find_or_create_by consumer_id: params[:uuid], action_id: params[:action_id]
    @action = @action_datum.action
  end

  def update
  end
end
