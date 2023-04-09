<script lang="ts">
  import { post, put } from '$utils/fetch';
  import {} from '@rails/activestorage';
  import { FileChecksum } from '@rails/activestorage/src/file_checksum';
  import { BlobUpload } from '@rails/activestorage/src/blob_upload';

  let fileInput: HTMLInputElement;
  let file: File;
  let result: JsonResponse;

  type JsonResponse = {
    url: string;
    headers: string;
    blob_id: number;
    signed_blob_id: string;
  };

  const calculateChecksum = async (file: File): Promise<string> => {
    return new Promise((resolve, reject) => {
      FileChecksum.create(file, (error: Error, checksum: string) => {
        if (error) {
          reject(error);
          return;
        }

        resolve(checksum);
      });
    });
  };

  const handleFileSelected = async () => {
    if (fileInput.files && fileInput.files[0]) {
      file = fileInput.files[0];

      const checksum = await calculateChecksum(file);

      const response = await post('/v1/test', {
        avatar: {
          filename: file.name,
          byte_size: file.size,
          checksum: checksum,
          content_type: file.type
        }
      });

      result = (await response.json()) as JsonResponse;
      let headers = JSON.parse(result.headers);
      let url = result.url;

      const upload = new BlobUpload({
        file: file,
        directUploadData: { headers: headers as Record<string, string>, url }
      });

      const uploadPromise = new Promise<void>((resolve, reject) => {
        const uploadCallback = (error: Error | undefined) => {
          if (error) {
            console.error('Upload failed:', error);
            reject(error);
          } else {
            resolve();
          }
        };

        upload.create(uploadCallback);
      });

      await uploadPromise;
    }
  };

  const handleSubmit = async () => {
    const final = await put('/v1/test', {
      signed_blob_id: result.signed_blob_id
    });
  };
</script>

<form on:submit|preventDefault={handleSubmit}>
  <label>
    Upload Avatar:
    <input type="file" bind:this={fileInput} on:change={handleFileSelected} />
  </label>

  <button type="submit" class="bg-blue-400">Submit</button>
</form>
