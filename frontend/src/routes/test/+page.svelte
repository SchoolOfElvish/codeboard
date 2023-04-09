<script lang="ts">
  import { post, put } from '$utils/fetch';
  import {} from '@rails/activestorage';
  import { FileChecksum } from '@rails/activestorage/src/file_checksum';
  import { BlobUpload } from '@rails/activestorage/src/blob_upload';

  let fileInput: HTMLInputElement;

  type Avatar = {
    filename: string;
    byte_size: number;
    checksum: string;
    content_type: string;
  };

  interface JsonResponse {
    url: string;
    headers: string;
    blob_id: number;
    signed_blob_id: string;
  }

  let avatar: Avatar;

  const handleFileSelected = async () => {
    if (fileInput.files && fileInput.files[0]) {
      const file = fileInput.files[0];
      console.log(file);

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

      const checksum = await calculateChecksum(file);
      console.log('File checksum:', checksum);

      const response = await post('/v1/test', {
        avatar: {
          filename: file.name,
          byte_size: file.size,
          checksum: checksum,
          content_type: file.type
        }
      });

      let result = (await response.json()) as JsonResponse;
      console.log(result);
      let headers = JSON.parse(result.headers);
      let url = result.url;

      const upload = new BlobUpload({
        file: file,
        directUploadData: { headers: headers as Record<string, string>, url }
      });

      console.log(upload);

      // Wrap upload.create() in a Promise
      const uploadPromise = new Promise<void>((resolve, reject) => {
        const uploadCallback = (error: Error | undefined) => {
          if (error) {
            console.error('Upload failed:', error);
            reject(error); // Reject the promise on error
          } else {
            console.log('Upload successful');
            resolve(); // Resolve the promise on success
          }
        };

        upload.create(uploadCallback);
      });

      // Wait for the upload to finish
      await uploadPromise;

      // Now execute the final part
      const final = await put('/v1/attach_avatar', {
        result: {
          signed_blob_id: result.signed_blob_id
        }
      });
    }
  };

  const handleSubmit = () => {
    console.log('Successfully submitted');
  };
</script>

<form on:submit|preventDefault={handleSubmit}>
  <label>
    Upload Avatar:
    <input type="file" bind:this={fileInput} on:change={handleFileSelected} />
  </label>

  <button type="submit" class="bg-blue-400">Submit</button>
</form>
