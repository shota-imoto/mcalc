require 'rails_helper'

RSpec.describe JwtAuthentication do
  describe 'decode' do
    include JwtAuthentication
    let(:user) { create(:user) }
    let(:token) { issue(user.id) }

    subject { decode(token)[0]["sub"] }
    context 'ユーザーIDを渡してエンコードした後にデコードをした場合' do
      it 'デコードされたユーザーIDがエンコード前の値と一致する' do
        is_expected.to eq user.id
      end
    end
  end
end
