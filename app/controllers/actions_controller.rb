class ActionsController < ApplicationController
  before_action :require_login!
  layout false, only: :frame

  def frame
    @action = Action.find params[:action_id]
    @enabled = @action.consumers.where(uuid: params[:uuid]).length == 1
  end

  def toggle
    action = Action.find params[:action_id]
    consumer = Consumer.find params[:uuid]
    if action.consumers.where(uuid: params[:uuid]).length == 1
      consumer.actions.delete action
    else
      consumer.actions.append action
    end
    redirect_to action_frame_path(consumer, action)
  end

  def edit
  end

  def update
  end
end
