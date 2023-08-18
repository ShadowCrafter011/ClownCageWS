class ConsumerController < ApplicationController
    def index
        if Consumer.count > 0
            redirect_to consumer_path Consumer.last
        end
    end

    def show
        
    end
end
