module JwtAuthentication
  require 'jwt'

  def issue(user_id)
    rsa_private_str = Rails.application.credentials.jwt[:private].gsub("\\n", "\n")
    rsa_private = OpenSSL::PKey::RSA.new(rsa_private_str)
    expires_in = 1.month.from_now
    payload = {sub: user_id, iat: expires_in.to_i}
    token = JWT.encode(payload, rsa_private, 'RS256')
  end

  def decode(token)
    rsa_private_str = Rails.application.credentials.jwt[:private].gsub("\\n", "\n")
    rsa_private = OpenSSL::PKey::RSA.new(rsa_private_str)
    rsa_public = rsa_private.public_key
    payload = JWT.decode(token, rsa_public, true, {algorithm: 'RS256'})
  end
end
