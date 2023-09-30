class ConsumerController < ApplicationController
    before_action :require_login!
    before_action :require_admin!, only: [:update, :lock, :delete]
    layout false, only: :frame

    def index
        if Consumer.count > 0
            redirect_to consumer_path(cookies.encrypted[:consumer] || Consumer.last)
        end
    end

    def show
        unless Consumer.exists? params[:uuid]
            return redirect_to consumer_path(Consumer.last)
        end

        cookies.encrypted[:consumer] = params[:uuid]

        @consumer = Consumer.find(params[:uuid])

        @plugins = Action::plugins
        @dispatched = Action::dispatched
    end

    def frame
        @consumer = Consumer.find(params[:uuid])
    end

    def navbar
        @consumer = Consumer.find(params[:uuid])
        @consumers = Consumer.order(created_at: :desc).filter {|con| con != @consumer}

        permitted = params.permit(:uuid, :action_id, :folder_id, :controller_name, :action_name)
        @url_params = permitted.merge(controller: permitted[:controller_name], action: permitted[:action_name])
        @url_params = @url_params.except(:controller_name, :action_name)
        if permitted[:action_id].present?
            @url_params = @url_params.merge(action_id: permitted[:action_id])
        end
        if permitted[:folder_id].present?
            @url_params = @url_params.merge(folder_id: permitted[:folder_id])
        end
    end 

    def update
        Consumer.find(params[:uuid]).update nickname_params
        redirect_to consumer_path params[:uuid]
    end

    def lock
        Consumer.find(params[:uuid]).toggle_lock
        redirect_to consumer_path params[:uuid]
    end

    def delete
        Consumer.destroy params[:uuid]
        redirect_to consumers_path
    end

    private
    def nickname_params
        params.require(:consumer).permit(:nickname)
    end
end
