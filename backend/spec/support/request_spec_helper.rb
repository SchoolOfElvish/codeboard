module RequestSpecHelper
  
  def auth_user
    user = create(:user)
    token = Jwt::Issuer.call(user)[0]
    return {'Authorization' => "Bearer #{token}"}
  end
end