class Api::V1::AssetRecordController < ApplicationController
  def new
    serializer = ResponseSerializer.new(Response.new(status: 'success', message: "set configure", user_id: 1))
    render json: serializer.serializable_hash.to_json
  end
end
