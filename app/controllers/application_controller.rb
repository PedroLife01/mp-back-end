class ApplicationController < ActionController::API
    def not_found
        render json: { error: "404 not found" }
    end

    def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            decoded = JsonWebToken.decode(header)
            authenticated_user = User.find(decoded[:user_id])
            
            # alice can only modify things pertaining to alice, 
            # bob can only modify things pertaining to bob; 
            # an admin can modify anything
            if ((authenticated_user.id != request.params[:id].to_i) &&
                (authenticated_user.is_admin == false))
                render json: { msg: "unauthorized request" }, status: :unauthorized
            end

        rescue ActiveRecord::RecordNotFound => err
            render json: { error: err.message }, status: :unauthorized
        rescue JWT::DecodeError => err
            render json: { error: err.message }, status: :unauthorized
        end
    end

    # only an admin can create/modify books, movies, series, tags and
    # GET or POST to other users rows
    def authorize_admin_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
            decoded = JsonWebToken.decode(header)
            authenticated_user = User.find(decoded[:user_id])
            
            if authenticated_user.is_admin == false
                render json: {msg: "you have no power here! (no admin rights)" }, status: :unauthorized
            end

        rescue ActiveRecord::RecordNotFound => err
            render json: { errors: err.message }, status: :unauthorized
        rescue JWT::DecodeError => err
            render json: { errors: err.message }, status: :unauthorized
        end
    end
end
