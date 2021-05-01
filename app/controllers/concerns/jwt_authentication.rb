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


  class Decode
    GOOGLE_TOKEN_URL = "https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com"

    attr_reader :token

    def initialize(token)
      @token = token
    end

    def payload
      JWT.decode(token, certification(public_key), true, { algorithm: 'RS256', verify_iat: false })
    end

    private

    def public_key
      google_key_set[key_id]
    end

    def certification(public_key)
      OpenSSL::X509::Certificate.new(public_key).public_key
    end

    def key_id
      no_verificated_payload(token)[1]["kid"]
    end

    def no_verificated_payload(token)
      JWT.decode(token, nil, false, {algorithm: 'RS256'})
    end

    def google_key_set
      JSON.parse(google_key_set_json).map {|k, v| [k, v] }.to_h
    end

    def google_key_set_json
      Net::HTTP.get google_token_url
    end

    def google_token_url
      URI.parse(GOOGLE_TOKEN_URL)
    end
  end
end


