class Api::MovieController < ApplicationController
    before_action :authorize_admin_request

    def create
        movie = Movie.new(movie_params)
        movie.save!

        render json: movie, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end

    def index
        movies = Movie.all

        render json: movies, status: :ok
    end

    def movie
        movie = Movie.find_by(params[:id])

        render json: movie, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def destroy
        movie = Movie.find(params[:id])

        if movie.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def movie_params
            params.require(:movie).permit(:id, :name)
        end
end
