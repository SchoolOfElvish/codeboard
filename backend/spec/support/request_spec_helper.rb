# frozen_string_literal: true

module RequestSpecHelper
  def auth_header_for(user)
    token = Jwt::Issuer.call(user)[0]
    { 'Authorization' => "Bearer #{token}" }
  end
end
