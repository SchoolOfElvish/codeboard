# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      include Dry::Monads::Result::Mixin

      def update
        Users::AddBirthdate.new.call(
          birthdate: params[:birthdate],
          user: current_user
        )
      end
    end
  end
end
