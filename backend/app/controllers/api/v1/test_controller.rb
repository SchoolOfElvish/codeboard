# frozen_string_literal: true

module Api
  module V1
    class TestController < ApplicationController
      include Dry::Monads::Result::Mixin

      def create
        case create_blob
        in Success(blob)
          render json: {
            url: blob.service_url_for_direct_upload(expires_in: 10.minutes),
            headers: blob.service_headers_for_direct_upload.to_json,
            blob_id: blob.id,
            signed_blob_id: blob.signed_id
          }
        in Failure(error)
          render json: { error: error.full_messages }, status: :unprocessable_entity
        end
      end

      def update
        case put_avatar
        in Success(:upload)
          render json: { message: 'Avatar attached successfully' }, status: :ok
        in Failure(error)
          render json: { error: }, status: :unprocessable_entity
        end
      end

      private

      def create_blob
        Users::CreateBlob.new.call(avatar_params)
      end

      def put_avatar
        Users::PutAvatar.new.call(url_params, current_user)
      end

      def avatar_params
        params.require(:avatar).permit(:filename, :byte_size, :checksum, :content_type)
      end

      def url_params
        params.permit(:signed_blob_id)
      end
    end
  end
end
