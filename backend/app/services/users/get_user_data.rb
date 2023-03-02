# frozen_string_literal: true

module Users
  class GetUserData < Core::Service
    def call(user:)
      Success[user.email, user.first_name, user.last_name, user.birthdate]
    end
  end
end
