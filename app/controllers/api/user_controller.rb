class Api::UserController < ApplicationController
    # only a valid jwt can make a request
    # you don't need a jwt to create a user, obviously
    before_action :authorize_request, except: [:create]

    # only an admin can index all users
    before_action :authorize_admin_request, only: [:index]

    def create
        user = User.new(user_params)

        if user.save
            render json: user, status: :created
        else
            render json: user.errors, status: :unprocessable_entity
        end


    rescue StandardError => err
        render json: { error: err }, status: :bad_request
    end

    def index
        users = User.all

        render json: users, status: :ok
    end

    def show
        user = User.find_by!(id: params[:id])

        render json: user, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def update
        user = User.find_by(id: params[:id])
        user.update(user_params)

        if user.save
            render json: user, status: :created
        else
            render json: user.errors, status: :unprocessable_entity
        end

    rescue StandardError => err
        render json: {merror: err}, status: :bad_request
    end

    def destroy
        user = User.find_by(id: params[:id])

        if user.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def user_params
            params.permit(:id, :name, :email, :password)
        end
        
end
