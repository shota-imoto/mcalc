require 'rails_helper'

RSpec.describe "Root", :type => :request do
  describe 'index' do
    include_context :user_with_rest_time_calc_config
    require 'json'
    include JwtAuthentication
    let(:jwt_token) { issue(user.id)}

    context "JWTトークンが渡された場合" do
      let(:headers) { { Authorization: jwt_token } }

      it "RestTimeCalcクラスのオブジェクトがシリアライズされて返される" do
        get api_v1_root_path, headers: headers
        expect(JSON.parse(response.body).dig("data", "type")).to eq "rest_time_calc"
      end
    end
  end

end
