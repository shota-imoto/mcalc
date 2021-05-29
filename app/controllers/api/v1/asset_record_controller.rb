class Api::V1::AssetRecordController < ApplicationController
  before_action :authenticate
  before_action :set_asset_record

  def create
    @asset_record.assign_attributes(asset_record_params)
    serializer = ResponseSerializer.new(create_response)
    render json: serializer.serializable_hash.to_json
  end

  private

  def set_asset_record
    @asset_record = AssetRecord.find_by_month_or_initialize_by(user: @user, date: date_params)
  end

  def create_response
    if @user.nil?
      Response.new(status: 'error', message: '不正なアクセス')
    elsif @asset_record.save
      Response.new(status: 'success', message: "set configure", user_id: @user.id)
    else
      Response.new(status: 'error', message: @asset_record.errors.full_messages, user_id: @user.id)
    end
  end

  def date_params
    AssetRecordDate.new(params[:asset_record][:date]).date
  end

  def asset_record_params
    params.require(:asset_record).permit(:amount, :date).merge(user: @user)
  end
end
