module Api
  module V1
    class UsersController < ApplicationController
      include Dry::Monads::Result::Mixin

      def update
        User::Add_Birthdate.new.call(
          birthdate: params[:birthdate]
        )
      end

    end
  end
end