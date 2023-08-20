class ConsumerController < ApplicationController
    before_action :require_login!
    before_action :require_admin!, only: [:update, :lock, :delete]
    layout false, only: :frame

    def index
        if Consumer.count > 0
            redirect_to consumer_path Consumer.last
        end
    end

    def show
        unless Consumer.exists? params[:uuid]
            return redirect_to consumers_path
        end

        @consumer = Consumer.find(params[:uuid])
        @consumers = Consumer.order(created_at: :desc).filter {|con| con != @consumer}

        @plugins = Action::plugins
        @dispatched = Action::dispatched
    end

    def frame
        @consumer = Consumer.find(params[:uuid])
    end

    def update
        Consumer.find(params[:uuid]).update nickname_params
        redirect_to consumer_path params[:uuid]
    end

    def lock
        consumer = Consumer.find(params[:uuid])
        consumer.update locked: !consumer.locked
        redirect_to consumer_path consumer
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
