module Api::V1
  class Students::DashboardsController < ApiController
    def index
      render json: "hello, world!"
    end
  end
end
