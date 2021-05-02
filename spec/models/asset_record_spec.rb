require 'rails_helper'

RSpec.describe AssetRecordDate, type: :model do
  describe 'date' do
    let(:user) { create(:user) }
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

      it '日は常に1日が返される' do
        expect(subject.day).to eq 1
      end

      it '時刻は常に00:00が返される' do
        expect(subject.to_s(:time)).to eq expected_time
      end
    end
  end

  describe 'validation' do
    let(:user) { create(:user) }
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
