class ActionsController < ApplicationController
  before_action :require_login!
  layout false, only: :frame

  def dispatch_action
    callback_uuid = Action.find(params[:action_id]).dispatch(params[:uuid])

    if callback_uuid.present?
      redirect_to action_frame_path, notice: { state: "dispatched", callback_uuid: callback_uuid }
    else
      redirect_to action_frame_path
    end
  end

  def force_dispatch
    force_data = {}
    params.each_key do |key|
      if key.starts_with? "force_"
        force_data[key.to_s.sub("force_", "").to_sym] = params[key]
      end
    end

    callback_uuid = Action.find(params[:action_id]).dispatch(params[:uuid], force_data)

    if callback_uuid.present?
      redirect_to action_edit_path, notice: { state: "dispatched", callback_uuid: callback_uuid }
    else
      redirect_to action_edit_path
    end
  end

  def action_status
    dispatch = Dispatch.find(params[:callback_uuid])
    render json: { success: true, name: dispatch.name, executed: dispatch.executed, error: dispatch.error }
  end

  def frame
    @action = Action.find params[:action_id]
    @enabled = @action.enabled? params[:uuid]

    create_dispatch_data
  end

  def toggle
    action_datum = ActionDatum::find_or_create_by(consumer_id: params[:uuid], action_id: params[:action_id])
    return unless action_datum.action.plugin?
    action_datum.toggle
    redirect_to action_frame_path
  end

  def edit
    if notice == "reset"
      @toast_title = "Data reset"
      @toast_body = "Data for this consumer and action has been reset to default"
    elsif notice == "save"
      @toast_title = "Data saved"
      @toast_body = "Data saved for this consumer and action"
    end

    @action_datum = ActionDatum::find_or_create_by consumer_id: params[:uuid], action_id: params[:action_id]
    @action = @action_datum.action
    @formatted_json = JSON.pretty_generate(JSON.parse(@action_datum.get_data), indent: "    ")

    create_dispatch_data
  end

  def update
    action_datum = ActionDatum::find_or_create_by consumer_id: params[:uuid], action_id: params[:action_id]
    success = action_datum.set_data params[:data]
    redirect_to action_edit_path, notice: success ? "save" : { message: "invalid_json", override_data: params[:data] }
  end

  def reset
    action_datum = ActionDatum::find_or_create_by consumer_id: params[:uuid], action_id: params[:action_id]
    action_datum.update data: nil
    redirect_to action_edit_path, notice: "reset"
  end

  private
  def create_dispatch_data
    @dispatch_data = {
        turbo_method: :post,
        controller: "tippy",
        tippy_placement: "bottom"
    }
    @dispatch_button_name = "Dispatch"

    if (notice.present? && notice["state"] == "dispatched")
      @dispatch_button_name = "Sent"
      @dispatch_data[:controller] = "tippy action-status"
      @dispatch_data[:callback_uuid] = notice["callback_uuid"]
    end
  end
end
