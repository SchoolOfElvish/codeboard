# frozen_string_literal: true

module Users
  class Update < Core::Service
    def call(user:, birthdate:)
      @user = user
      @birthdate = birthdate

      add_birthdate
    end

    private

    attr_reader :user, :birthdate

    def add_birthdate
      user.update(birthdate:) ? Success() : Failure(:user_not_updated)
    end
  end
end
