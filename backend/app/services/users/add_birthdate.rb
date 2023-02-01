# frozen_string_literal: true

module Users
  class Add_Birthdate < Core::Service
    def call(birthdate:, user:)
      @birthdate = birthdate
      @user = current_user
      
      add_birthdate
    end

    private

    def add_birthdate
      @user.update(birthdate: @birthdate) ? Success() : Failure()
    end

  end
end