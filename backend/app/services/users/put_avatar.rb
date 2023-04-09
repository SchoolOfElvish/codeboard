# frozen_string_literal: true

module Users
  class PutAvatar < Core::Service
    def call(url_params, current_user)
      user = current_user
      @signed_blob_id = url_params[:signed_blob_id]
      blob = yield find_blob
      user.avatar.attach(blob)
      Success(:upload)
    end

    private

    attr_reader :signed_blob_id, :blob

    def find_blob
      blob = ActiveStorage::Blob.find_signed(@signed_blob_id)
      blob ? Success(blob) : Failure(:blob_not_found)
    end
  end
end
