# frozen_string_literal: true

module Users
  class CreateBlob < Core::Service
    SUPPORTED_IMAGE_FORMATS = %w[image/jpeg image/png image/gif image/bmp image/tiff image/webp].freeze

    def call(avatar_params)
      @filename = avatar_params[:filename]
      @byte_size = avatar_params[:byte_size]
      @checksum = avatar_params[:checksum]
      @content_type = avatar_params[:content_type]

      result = check_for_valid_type(@content_type)
      if result.success?
        create_before_direct_upload
      else
        Failure(:unsupported_type)
      end
    end

    private

    attr_reader :filename, :byte_size, :checksum, :content_type

    def check_for_valid_type(content_type)
      SUPPORTED_IMAGE_FORMATS.include?(content_type) ? Success() : Failure()
    end

    def create_before_direct_upload
      blob = ActiveStorage::Blob.create_before_direct_upload!(filename:, byte_size:, checksum:, content_type:)
      blob ? Success(blob) : Failure(:blob_failure)
    end
  end
end
