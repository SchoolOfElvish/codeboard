# frozen_string_literal: true

module Users
  class GetData < Core::Service
    def call(user:)
      @user = user
      Success(user.email)
    end
  end
end
