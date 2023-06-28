class Api::ShowController < ApplicationController
    before_action :authorize_admin_request

    def create
        show = Show.new(show_params)
        show.save!

        render json: show, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end

    def index
        shows = Show.all

        render json: shows, status: :ok
    end

    def show
        show = Show.find_by(params[:id])

        render json: show, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def destroy
        show = Show.find(params[:id])

        if show.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def show_params
            params.require(:show).permit(:id, :name)
        end
end
