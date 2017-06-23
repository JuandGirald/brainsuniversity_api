module Api::V1
  class Teachers::DashboardsController < ApiController
    def index
      render json: "hello, world!"
    end
  end
end
