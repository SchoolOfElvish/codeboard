# frozen_string_literal: true

module Users
  class AddBirthdate < Core::Service
    def call(birthdate:, user:)
      @birthdate = birthdate
      @user = user

      add_birthdate
    end

    private

    attr_reader :birthdate, :user

    def add_birthdate
      user.update(birthdate:) ? Success() : Failure(:user_not_updated)
    end
  end
end
