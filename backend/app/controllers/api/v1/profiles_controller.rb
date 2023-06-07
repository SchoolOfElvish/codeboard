# frozen_string_literal: true

module Api
  module V1
    class ProfilesController < ApplicationController
      include Dry::Monads::Result::Mixin

      def show
        case receive_user_data
        in Success[user_data]
          render json: user_data, status: :ok
        in Failure[error]
          render json: { errors: }, status: :unprocessable_entity
        end
      end

      # rubocop:disable Metrics/MethodLength

      def create
        case create_blob
        in Success(blob)
          render json: {
            url: blob.service_url_for_direct_upload(expires_in: 10.minutes),
            headers: blob.service_headers_for_direct_upload.to_json,
            blob_id: blob.id,
            signed_blob_id: blob.signed_id
          }
        in Failure(:unsupported_type)
          render json: { error: [t('errors.unsupported_format')] }, status: :unprocessable_entity
        in Failure(error)
          render json: { error: error.full_messages }, status: :unprocessable_entity
        end
      end

      # rubocop:enable Metrics/MethodLength

      def update
        case update_user_info
        in Success(user)
          head :no_content
        in Failure[error]
          render json: { error: error.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def update_user_info
        Users::UpdateUser.new.call(
          user: current_user,
          user_params: user_info_params
        )
      end

      # rubocop:disable Metrics/AbcSize

      def receive_user_data
        user_data = {
          first_name: current_user.first_name,
          last_name: current_user.last_name,
          email: current_user.email,
          birthdate: current_user.birthdate,
          about_info: current_user.about_info,
          avatar: current_user.avatar.attached? ? url_for(current_user.avatar.variant(:thumb)) : nil
        }
        Success(user_data)
      end

      # rubocop:enable Metrics/AbcSize

      def user_info_params
        params.permit(:first_name, :last_name, :birthdate, :about_info, :avatar, :signed_blob_id)
      end

      def create_blob
        Users::CreateBlob.new.call(avatar_params)
      end

      def put_avatar
        Users::PutAvatar.new.call(url_params, current_user)
      end

      def avatar_params
        params.require(:avatar).permit(:filename, :byte_size, :checksum, :content_type)
      end
    end
  end
end
