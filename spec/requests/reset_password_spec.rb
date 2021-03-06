require 'rails_helper'
require 'json'

RSpec.describe "ResetPassword", :type => :request do
  let(:user) { create(:user) }
  let(:token) { user.reset_password_token }
  let(:new_password) { "new#{user.password}" }
  let(:new_password_confirmation) { "new#{user.password}" }
  let(:message) { JSON.parse(response.body).dig("data", "attributes", "message").first }

  describe 'update' do
    before { patch api_v1_users_password_path, params: { user: { user_id: user.id, reset_password_token: token, password: new_password, password_confirmation: new_password_confirmation } } }

    shared_examples :success_sign_in_by_new_password do
      subject { user.reload.authenticate(new_password)}
      context '変更後のパスワードでログイン認証を行った場合' do
        it { is_expected.to be_truthy}
      end
    end

    shared_examples :error_sign_in_by_new_password do
      subject { user.reload.authenticate(new_password)}
      context '変更後のパスワードでログイン認証を行った場合' do
        it { is_expected.to be_falsey}
      end
    end


    context '正常系' do
      it_behaves_like :success_sign_in_by_new_password
    end

    context '確認パスワードに誤りがある場合' do
      let(:new_password_confirmation) { "wrong#{user.password}" }
      it_behaves_like :error_sign_in_by_new_password
      it 'パスワード不一致時のエラーメッセージが返される' do
        expect(message).to eq 'パスワードが一致しません'
      end
    end

    context 'パスワードリセット用のトークンに誤りがある場合' do
      let(:token) { 'wrong_token' }
      it_behaves_like :error_sign_in_by_new_password
      it "トークン誤りのエラーメッセージが返される" do
        expect(message).to eq '認証情報に誤りがあります'
      end
    end
  end

end
