require 'rails_helper'

shared_context :authenticated_header_by_user do
  # before_include_this_context, you have to define user factory.
  include JwtAuthentication

  let(:token) { issue(user.id) }
  let(:headers) { { Authorization: token } }
end
