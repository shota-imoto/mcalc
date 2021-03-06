class ResponseWithToken < Response
  attr_accessor :token

  def initialize(params)
    super
    @token = params[:token]
  end
end
