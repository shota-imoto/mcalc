module JwtAuthentication
  require 'jwt'

  @@rsa_private = OpenSSL::PKey::RSA.generate(2048)
  @@rsa_public = @@rsa_private.public_key

  def issue(user_id)
    @rsa_private = OpenSSL::PKey::RSA.generate 2048
    @rsa_public = @rsa_private.public_key
    expires_in = 1.month.from_now
    payload = {user_id: user_id, exp: expires_in.to_i}

    token = JWT.encode(payload, @rsa_private, 'RS256')
  end
end
