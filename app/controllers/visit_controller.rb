class VisitController < ApplicationController
    before_action :require_admin!

    def index
        @visits = Visit.order(created_at: :desc)
    end
end
