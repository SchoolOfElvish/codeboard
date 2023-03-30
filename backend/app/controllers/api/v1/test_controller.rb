# frozen_string_literal: true

module Api
  module V1
    class TestController < ApplicationController
      include Dry::Monads::Result::Mixin

      def update
        case update_user_avatar()
        in Success(user)
          head :no_content
        in Failure[error]
          render json: { error: }, status: :unprocessable_entity
        end
      end

      private

      def update_user_avatar
        base64_string = user_info_params[:avatar].to_s
        file_data = Base64.decode64(base64_string.split(',')[1])
        tempfile = Tempfile.new("uploaded_file")
        file_type = base64_string.match(/data:(.*);base64/)[1]
        file_name = user_info_params.keys.first
        # binding.pry
        tempfile.binmode
        tempfile.write(file_data)
        tempfile.rewind
        uploaded_file = ActionDispatch::Http::UploadedFile.new(
          tempfile: tempfile,
          filename: file_name,
          type: file_type
        )

        user = current_user
        if user.avatar.attach(uploaded_file)
          Success(user)
        end
        
      end

      def user_info_params
        params.permit(:avatar)
      end
    end
  end
end
