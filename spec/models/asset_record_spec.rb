require 'rails_helper'

RSpec.describe AssetRecordDate, type: :model do
  let(:user) { create(:user) }

  describe 'date' do
    let(:asset_record) { create(:asset_record, date: date, user: user) }
    let(:expected_time) { Time.zone.parse(date).at_beginning_of_day.to_s(:time) }
    subject { asset_record.date }

    context '任意の日時を渡した場合' do
      let(:date) { '2021-01-31 12:34:56' }
      it '登録した年が返される' do
        expect(subject.year).to eq Time.zone.parse(date).year
      end

      it '登録した月が返される' do
        expect(subject.month).to eq Time.zone.parse(date).month
      end

      it '登録した日が返される' do
        expect(subject.day).to eq Time.zone.parse(date).day
      end
    end
  end

  describe 'find_by_month_or_initialize_by' do
    let!(:old_asset_record) { create(:asset_record, user: user, date: Time.zone.today.beginning_of_month) }
    subject { AssetRecord.find_by_month_or_initialize_by(date: date) }

    context 'old_asset_record.dateと同じ月内の異なる日付が渡された場合' do
      let(:date) { Time.zone.today.end_of_month }

      it 'old_asset_recordが取得される' do
        is_expected.to eq old_asset_record
      end
    end

    context 'old_asset_record.dateと異なる月の日付が渡された場合' do
      let(:date) { Time.zone.today + 1.month }

      it '新しいオブジェクトが生成される' do
        expect(subject.new_record?).to be_truthy
      end

      it 'dateの値が正常' do
        expect(subject.date).to eq date
      end
    end
  end


  describe 'validation' do
    let(:date) { '2021-01-31 12:34:56' }

    context 'ユニーク制約' do
      let!(:asset_record) { create(:asset_record, date: date, user: user) }
      context '同じユーザー、同じ年月のレコードの場合' do
        let(:new_asset_record) { build(:asset_record, date: new_record_date, user: user) }
        let(:new_record_date) { date }
        before { new_asset_record.valid? }

        it 'バリデーションエラー' do
          expect(new_asset_record.errors[:date]).to eq ["has already been taken"]
        end
      end
      context '別のユーザー、同じ年月のレコードの場合' do
        let(:other_user) { create(:user) }
        let(:new_asset_record) { build(:asset_record, date: new_record_date, user: other_user) }
        let(:new_record_date) { date }
        before { new_asset_record.valid? }

        it 'エラーは発生しない' do
          expect(new_asset_record.errors[:date]).to eq []
        end
      end

      context '同じユーザー、別の年月のレコードの場合' do
        let(:new_asset_record) { build(:asset_record, date: new_record_date, user: user) }
        let(:new_record_date) { Time.zone.parse(date).change(month: 12).to_s }
        before { new_asset_record.valid? }

        it 'エラーは発生しない' do
          expect(new_asset_record.errors[:date]).to eq []
        end
      end
    end
  end
end
