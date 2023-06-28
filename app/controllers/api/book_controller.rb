class Api::BookController < ApplicationController
    before_action :authorize_admin_request
    
    def create
        book = Book.new(book_params)
        book.save!

        render json: book, status: :created

    rescue StandardError => err
        render json: err, status: :bad_request
    end

    def index
        books = Book.all

        render json: books, status: :ok
    end

    def show
        book = Book.find_by(params[:id])

        render json: book, status: :ok

    rescue StandardError => err
        render json: {error: err}, status: :not_found
    end

    def destroy
        book = Book.find(params[:id])

        if book.destroy
            head :no_content
        end

        rescue StandardError => err
            render json: {error: err}, status: :bad_request
    end

    private
        def book_params
            params.require(:book).permit(:id, :name)
        end
end
