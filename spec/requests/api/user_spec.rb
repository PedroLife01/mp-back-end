require 'rails_helper'

RSpec.describe "Api::Users", type: :request do
  describe "POST /user" do
    let(:user_params) do
      FactoryBot.attributes_for(:user)
    end

    context "good POST" do
      it "returns 201 CREATED" do
        post "/api/user", params:{user: user_params}
        expect(response).to have_http_status(:created)
      end
    end

    context "bad params" do
      it "returns 400 BAD REQUEST" do
        post "/api/user", params:{user: nil}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context "duplicate params" do
      it "returns 400 BAD REQUEST" do
        post "/api/user", params:{user: user_params}
        post "/api/user", params:{user: user_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
  

  describe "PATCH /user/:id" do
    PSWD = "123456"
    user_params = {"name"=>"jhon doe"}
    
    context "good PATCH" do
      let(:user) { FactoryBot.create(:user, password: PSWD) }
      it "returns 200 OK" do
        token = JsonWebToken.encode(user_id: user.id)
        patch "/api/user/#{user.id}", params: {user: user_params}, headers: { "Authorization" => token }

        expect(response).to have_http_status(:ok)
      end
    end

    context "bad PATCH" do
      let(:user) { FactoryBot.create(:user, password: PSWD) }
      it "returns 401 UNAUTHORIZED" do
        token = nil
        patch "/api/user/#{user.id}", params: {user: user_params}, headers: { "Authorization" => token }

        expect(response).to have_http_status(:unauthorized)
      end
    end

  end


  describe "DELETE /user/:id" do
    
    context "good DELETE" do
      let(:user) { FactoryBot.create(:user) }
      
      it "returns 204 NO CONTENT" do
        token = JsonWebToken.encode(user_id: user.id)
        delete "/api/user/#{user.id}", headers: { "Authorization" => token }
        expect(response).to have_http_status(:no_content)
      end
    end

  end
end
