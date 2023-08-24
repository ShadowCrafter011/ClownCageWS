class ActionsController < ApplicationController
  before_action :require_login!
  layout false, only: :frame

  def dispatch_action
    Action.find(params[:action_id]).dispatch(params[:uuid])
  end

  def frame
    @action = Action.find params[:action_id]
    @enabled = @action.enabled? params[:uuid]
  end

  def toggle
    action_datum = ActionDatum::find_or_create_by(consumer_id: params[:uuid], action_id: params[:action_id])
    return unless action_datum.action.plugin?
    action_datum.toggle
    redirect_to action_frame_path(params[:uuid], params[:action_id])
  end

  def edit
  end

  def update
  end
end
