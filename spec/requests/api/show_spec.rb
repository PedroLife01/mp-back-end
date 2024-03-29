require 'rails_helper'

RSpec.describe "Api::Shows", type: :request do
  
  describe "POST /show" do
    let(:user) do 
      FactoryBot.create(:user)
    end
    let(:show_params) do 
      FactoryBot.attributes_for(:show)
    end

    context "good POST" do
      it "returns 201 CREATED" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/show", params:{show: show_params}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:created)
      end
    end

    context "bad params" do
      it "returns 400 BAD REQUEST" do
        token = JsonWebToken.encode(user_id: user.id)
        post "/api/show", params:{name: nil}, headers: {"Authorization" => token}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe "DELETE /show/:id" do
    let(:user) do 
      FactoryBot.create(:user)
    end
    let(:show) { FactoryBot.create(:show) }

    context "good DELETE" do
      it "returns 204 NO CONTENT" do
        token = JsonWebToken.encode(user_id: user.id)
        delete "/api/show/#{show.id}", headers: {"Authorization" => token}
        expect(response).to have_http_status(:no_content)
      end
    end
  end

end
