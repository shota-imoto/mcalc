require 'rails_helper'

RSpec.describe "SingIn", :type => :request do
  describe 'create' do
    let(:user) { create(:user) }
    let(:email) { user.email }
    let(:password) { user.password }

    let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }
    require 'json'

    before { post api_v1_users_sign_in_index_path, params: { user: { email: email, password: password } } }

    context '異常系' do
      it "レスポンスオブジェクトはstatus, messagesの3項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
    end

    context '異常系' do
      shared_examples :incorrect_email_or_password_error do
        it 'エラーメッセージが返される' do
          expect(attributes["message"]).to eq ["メールアドレスまたはパスワードが誤っています"]
        end
      end
      context '存在しないメールアドレスが入力された場合' do
        let(:email) { "wrong_#{user.email}" }
        it_behaves_like :incorrect_email_or_password_error
      end

      context '誤ったパスワードが入力された場合' do
        let(:password) { "wrong_#{user.password}" }
        it_behaves_like :incorrect_email_or_password_error
      end
    end
  end
end
