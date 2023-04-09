# frozen_string_literal: true

module Api
  module V1
    class TestController < ApplicationController
        
      def update
        filename = avatar_params[:filename]
        byte_size = avatar_params[:byte_size]
        checksum = avatar_params[:checksum]
        content_type = avatar_params[:content_type]
        blob = ActiveStorage::Blob.create_before_direct_upload!(filename:, byte_size:, checksum:, content_type:)
        render json: {
          url: blob.service_url_for_direct_upload(expires_in: 10.minutes),
          headers: blob.service_headers_for_direct_upload.to_json,
          blob_id: blob.id,
          signed_blob_id: blob.signed_id,
        }
        
        
        
      end
      
      def attach_avatar
        # binding.pry
        signed_blob_id = result_params[:signed_blob_id]
        blob = ActiveStorage::Blob.find_signed(signed_blob_id)

        current_user.avatar.attach(blob)

        render json: { message: 'Avatar attached successfully' }, status: :ok
      end

      private

      def avatar_params
        params.require(:avatar).permit(:filename, :byte_size, :checksum, :content_type)
      end

      def result_params
        params.require(:result).permit(:signed_blob_id)
      end
      
    end
  end
end
