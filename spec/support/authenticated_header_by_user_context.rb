require 'rails_helper'

shared_context :authenticated_header_by_user do
  # before_include_this_context, you have to define user factory.
  before do
    begin
      user
    rescue NameError => e
      raise e, 'before_include_this_context, you have to define user factory.'
    end
  end

  include JwtAuthentication

  let(:headers) { { Authorization: "Token example" } }
  before do
    certificate = double('certificate double')
    allow(certificate).to receive(:public_key).and_return('publick key mock')
    allow(OpenSSL::X509::Certificate).to receive(:new).and_return(certificate)
    allow(JWT).to receive(:decode).and_return([{"sub" => user.uuid}, {}])
  end
end
