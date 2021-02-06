class RetirementAssetConfigResponse
  attr_accessor :status, :message, :user_id

  def initialize(params)
    @status = params[:status]
    @message = params[:message]
    @user_id = params[:user_id]
  end
end
