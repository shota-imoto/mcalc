require 'rails_helper'

RSpec.describe "SingUp", :type => :request do
  require 'uri'
  describe 'create' do
    let(:user) { build(:user) }
    require 'json'

    before { post api_v1_users_sign_up_index_path, params: { user: user.attributes } }

    context "正常系" do
      let(:attributes) { JSON.parse(response.body).dig("data", "attributes") }

      it "レスポンスオブジェクトはstatus, messagesの2項目を返す" do
        expect(attributes.keys).to eq ["status", "message"]
      end
    end
  end

  describe 'confirm' do
    shared_examples :redirect_to_url_with_correct_params do
      it '正しいパラメータを持つURLにリダイレクトする' do
        expect(response).to redirect_to(url)
      end
    end

    let(:user) { create(:user, :before_confirm) }
    let(:token) { user.confirmation_token }
    let(:url) { "firecountdownapp://home?#{URI.encode_www_form(params)}" }

    before { get confirm_api_v1_users_sign_up_index_path, params: { user_id: user.id, confirmation_token: token } }

    context '正しいユーザー登録用トークンが渡される' do
      let(:params) { { status: 'success', message: '本登録が完了しました。登録したメールアドレスとパスワードを入力してログインしてください' } }
      it_behaves_like :redirect_to_url_with_correct_params
    end
    context '確認用メールの送信から30分以上経過している' do
      let(:user) { create(:user, :before_confirm, confirmation_sent_at: Time.zone.now - 30.minutes)}
      let(:params) { { status: 'error', message: '登録確認メールの期限が切れています' } }
      it_behaves_like :redirect_to_url_with_correct_params
    end
    context '誤ったユーザー登録用トークンが渡される' do
      let(:token) { "wrong_#{user.confirmation_token}" }
      let(:params) { { status: 'error', message: '登録確認トークンが一致しません' } }
      it_behaves_like :redirect_to_url_with_correct_params
    end
    context 'すでに認証が完了している' do
      let(:user) { create(:user, :before_confirm, confirmed_at: Time.zone.now)}
      let(:params) { { status: 'error', message: 'すでに本登録が完了しています' } }
      it_behaves_like :redirect_to_url_with_correct_params
    end
  end
end
