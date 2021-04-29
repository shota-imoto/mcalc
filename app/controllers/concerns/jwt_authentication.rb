module JwtAuthentication
  require 'net/http'
  require 'uri'
  require "json"

  require 'jwt'

  # TODO: リファクタリング
  def issue(user_id)
    rsa_private_str = Rails.application.credentials.jwt[:private].gsub("\\n", "\n")
    rsa_private = OpenSSL::PKey::RSA.new(rsa_private_str)
    expires_in = 1.month.from_now
    payload = {sub: user_id, iat: expires_in.to_i}
    token = JWT.encode(payload, rsa_private, 'RS256')
  end

  def decode(token)
    pp 'トークン'
    pp token 
    payload = JWT.decode(token, nil, false, {algorithm: 'RS256'})
    header = payload[1]
    uri = URI.parse('https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com')
    res = Net::HTTP.get(uri)
    data = JSON.parse(res).map {|k, v| [k, v] }.to_h
    public_key = data[header["kid"]]
    certificate = OpenSSL::X509::Certificate.new(public_key)
    JWT.decode(token, certificate.public_key, true, { algorithm: 'RS256', verify_iat: true })
  end
end


