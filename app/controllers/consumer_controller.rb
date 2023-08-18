class ConsumerController < ApplicationController
    def index
        if Consumer.count > 0
            redirect_to consumer_path Consumer.last
        end
    end

    def show
        @consumer = Consumer.find(params[:uuid])
        @consumers = Consumer.order(created_at: :desc).filter {|con| con != @consumer}
    end

    def frame
        @consumer = Consumer.find(params[:uuid])
    end
end
