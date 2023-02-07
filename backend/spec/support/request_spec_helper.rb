module RequestSpecHelper
  
  def auth_user(user)
    get '/users/confirm', params: {token: user.confirmation_token}
    post '/users/login', params: {email: user.email, password: 'password'}
    return json['auth_token']
  end
end