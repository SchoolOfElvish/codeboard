# frozen_string_literal: true

module Users
  class PutAvatar < Core::Service
    def call(signed_blob_id, current_user)
      user = current_user
      blob = yield find_blob(signed_blob_id)
      user.avatar.attach(blob)
      Success(:upload)
    end

    private

    attr_reader :signed_blob_id, :blob

    def find_blob(signed_blob_id)
      blob = ActiveStorage::Blob.find_signed(signed_blob_id)
      blob ? Success(blob) : Failure(:blob_not_found)
    end
  end
end
