# frozen_string_literal: true

module Users
  class CreateBlob < Core::Service
    def call(avatar_params)
      @filename = avatar_params[:filename]
      @byte_size = avatar_params[:byte_size]
      @checksum = avatar_params[:checksum]
      @content_type = avatar_params[:content_type]
      blob = create_before_direct_upload
    end

    private

    attr_reader :filename, :byte_size, :checksum, :content_type

    def create_before_direct_upload
      blob = ActiveStorage::Blob.create_before_direct_upload!(filename:, byte_size:, checksum:, content_type:)
      blob ? Success(blob) : Failure(:blob_failure)
    end
  end
end
