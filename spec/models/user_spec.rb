require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validates' do
    let(:user) { build(:user, nickname: nickname, email: email, password: password, password_confirmation: password_confirmation) }
    let(:nickname) { "ウォーレン・バフェット" }
    let(:email) { "test@example.com" }
    let(:password) { "1234azAZ" }
    let(:password_confirmation) { password }
    subject { user.valid? }

    context 'email' do
      context 'ユーザー名@"."を1文字以上含むドメインの形式のとき、バリデーションエラーが発生しない' do
        let(:email) { "t@e.c" }
        it { is_expected.to be_truthy }
      end

      context '@を含まないとき、バリデーションエラーが発生する' do
        let(:email) { "te.c" }
        it { is_expected.to be_falsey }
      end

      context 'ユーザー名を含まないとき、バリデーションエラーが発生する' do
        let(:email) { "@e.c" }
        it { is_expected.to be_falsey }
      end

      context 'ドメインに"."を含まないとき、バリデーションエラーが発生する' do
        let(:email) { "t@ec" }
        it { is_expected.to be_falsey }
      end

      context 'ドメインの１つ目の"."のあとに何も続かないとき、バリデーションエラーが発生する' do
        let(:email) { "t@e." }
        it { is_expected.to be_falsey }
      end
    end

    context 'password' do
      context '数字、半角英小文字、半角英大文字を含み8文字以上のとき、バリデーションエラーが発生しない' do
        let(:password) { "1234azAZ" }
        it { is_expected.to be_truthy }
      end

      context '半角英大文字を含まないとき、バリデーションエラーが発生する' do
        let(:password) { "1234azaz" }
        it { is_expected.to be_falsey }
      end

      context '半角英小文字を含まないとき、バリデーションエラーが発生する' do
        let(:password) { "1234AZAZ" }
        it { is_expected.to be_falsey }
      end

      context '数字を含まないとき、バリデーションエラーが発生する' do
        let(:password) { "azazAZAZ" }
        it { is_expected.to be_falsey }
      end

      context 'password_confirmationと一致しないとき、バリデーションエラーが発生する' do
        let(:password_confirmation) { password + "a" }
        it { is_expected.to be_falsey }
      end
    end
  end
end
