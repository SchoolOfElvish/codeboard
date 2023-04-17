<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import { put,post } from '$utils/fetch';
  import type { PageData } from './$types';
  import { _ } from 'svelte-i18n';
  import {} from '@rails/activestorage';
  import { FileChecksum } from '@rails/activestorage/src/file_checksum';
  import { BlobUpload } from '@rails/activestorage/src/blob_upload';

  export let data: PageData;

  type OperationStatus = 'success' | 'failure' | 'incompleted';

  type JsonResponse = {
    url: string;
    headers: string;
    blob_id: number;
    signed_blob_id: string;
  };

  let {
    first_name: firstName,
    last_name: lastName,
    email,
    birthdate,
    about_info: aboutInfo,
    avatar
  } = data.response;
  
  let AvatarFile: File;
  let status: OperationStatus = 'incompleted';
  let errors: string[];

  let fileInput: HTMLInputElement;
  let file: File;
  let uploadResult: JsonResponse;

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

      uploadResult = (await response.json()) as JsonResponse;
      let headers = JSON.parse(uploadResult.headers);
      let url = uploadResult.url;

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

  const submitUserData = async () => {
    const result = await put('/v1/users/me', {
      first_name: firstName,
      last_name: lastName,
      birthdate: birthdate,
      signed_blob_id: uploadResult.signed_blob_id,
      about_info: aboutInfo
    });

    result
      .error(422, async (error) => {
        errors = JSON.parse(error.message).error;
        status = 'failure';
        return error;
      })
      .res(() => (status = 'success'));
  };

  const closeAlert = () => {
    status = 'incompleted';
  };
</script>

<!-- https://tailwindui.com/components/application-ui/forms/form-layouts -->
<div class="lg:grid lg:grid-cols-12 lg:gap-x-5 mt-2 max-w-screen-xl container mx-auto">
  <aside class="py-6 px-2 sm:px-6 lg:col-span-3 lg:py-0 lg:px-0">
    <nav class="space-y-1">
      <a
        href="/"
        class="bg-gray-200 text-indigo-700 hover:bg-white hover:text-indigo-700 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
        aria-current="page"
      >
        <Icon name="UserCircle" />
        <span class="truncate">
          {$_(`pages.users.me.account`)}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="Key" />
        <span class="truncate">
          {$_(`pages.users.me.password`)}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="CreditCard" />
        <span class="truncate">
          {$_(`pages.users.me.billing_plan`)}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="UserGroup" />
        <span class="truncate">
          {$_(`pages.users.me.team`)}
        </span>
      </a>

      <a
        href="/"
        class="text-gray-900 hover:bg-gray-50 hover:text-gray-900 group flex items-center rounded-md px-3 py-2 text-sm font-medium"
      >
        <Icon name="SquaresPlus" />
        <span class="truncate">
          {$_(`pages.users.me.integrations`)}
        </span>
      </a>
    </nav>
  </aside>

  <div class="space-y-6 sm:px-6 lg:col-span-9 lg:px-0 bg-white">
    {#if status === 'failure'}
      <div role="alert" class="rounded border-l-4 border-red-500 bg-red-50 p-4">
        <strong class="block font-medium text-red-700"
          >{$_(`pages.users.me.something_went_wrong`)}</strong
        >
        <p class="mt-2 text-sm text-red-700">
          {#each errors as error}
            {error}
            <br />
          {/each}
        </p>
      </div>
    {:else if status === 'success'}
      <div class="rounded-md bg-green-100 p-4">
        <div class="flex">
          <div class="flex-shrink-0">
            <Icon name="CheckCircle" />
          </div>
          <div class="ml-3">
            <p class="text-sm font-medium text-green-800">Successfully uploaded</p>
          </div>
          <div class="ml-auto pl-3">
            <div class="-mx-1.5 -my-1.5">
              <button
                type="button"
                class="inline-flex rounded-md bg-green-50 p-1.5 text-green-500 hover:bg-green-100 focus:outline-none focus:ring-2 focus:ring-green-600 focus:ring-offset-2 focus:ring-offset-green-50"
                on:click|preventDefault={closeAlert}
              >
                <span class="sr-only">Dismiss</span>
                <Icon name="XMark" />
              </button>
            </div>
          </div>
        </div>
      </div>
    {/if}
    <form action="#" method="POST">
      <div class="space-y-12">
        <div class="space-y-6 bg-white py-6 px-4 sm:p-6 border-b">
          <div>
            <h3 class="text-base font-semibold leading-6 text-gray-900">Profile</h3>
            <p class="mt-1 text-sm text-gray-500">
              This information will be displayed publicly so be careful what you share.
            </p>
          </div>
          <div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
            <div class="col-span-full">
              <label for="photo" class="block text-sm font-medium leading-6 text-gray-900"
                >Photo</label
              >
              <div class="mt-2 flex items-center gap-x-3">
                <svg
                  class="h-12 w-12 text-gray-300"
                  viewBox="0 0 24 24"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    fill-rule="evenodd"
                    d="M18.685 19.097A9.723 9.723 0 0021.75 12c0-5.385-4.365-9.75-9.75-9.75S2.25 6.615 2.25 12a9.723 9.723 0 003.065 7.097A9.716 9.716 0 0012 21.75a9.716 9.716 0 006.685-2.653zm-12.54-1.285A7.486 7.486 0 0112 15a7.486 7.486 0 015.855 2.812A8.224 8.224 0 0112 20.25a8.224 8.224 0 01-5.855-2.438zM15.75 9a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0z"
                    clip-rule="evenodd"
                  />
                </svg>
                <label
                  for="file-upload"
                  class="relative cursor-pointer rounded-md bg-white py-1.5 px-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50"
                >
                  <input id="file-upload" name="file-upload" type="file" class="sr-only"  bind:this={fileInput} on:change={handleFileSelected}  />
                  Change</label
                >
              </div>
            </div>
          </div>
        </div>
        <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
          <div>
            <h3 class="text-base font-semibold leading-6 text-gray-900">
              {$_(`pages.users.me.personal_information`)}
            </h3>
            <p class="mt-1 text-sm text-gray-500">
              {$_(`pages.users.me.use_permament_email`)}
            </p>
          </div>

          <div class="grid grid-cols-6 gap-6">
            <div class="col-span-6 sm:col-span-3 ">
              <label for="first-name" class="block text-sm font-medium text-gray-700"
                >{$_(`pages.users.me.first_name`)}</label
              >
              <input
                bind:value={firstName}
                type="text"
                name="first-name"
                id="first-name"
                autocomplete="given-name"
                class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
              />
            </div>

            <div class="col-span-6 sm:col-span-3">
              <label for="last-name" class="block text-sm font-medium text-gray-700"
                >{$_(`pages.users.me.last_name`)}</label
              >
              <input
                bind:value={lastName}
                type="text"
                name="last-name"
                id="last-name"
                autocomplete="family-name"
                class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
              />
            </div>

            <div class="col-span-6 sm:col-span-3">
              <label for="email-address" class="block text-sm font-medium text-gray-700"
                >{$_(`pages.users.me.email`)}</label
              >
              <input
                bind:value={email}
                type="text"
                name="email-address"
                id="email-address"
                autocomplete="email"
                class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
              />
            </div>

            <!-- Datapicker -->

            <div class="col-span-4 sm:col-span-3 sm:col-start-1 sm:col-end-3">
              <label for="postal-code" class="block text-sm font-medium text-gray-700"
                >{$_(`pages.users.me.input_birthdate`)}</label
              >
              <div class="date-picker">
                <input
                  bind:value={birthdate}
                  class="mt-1 block w-full rounded-md border border-gray-300 py-2 px-3 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
                  type="date"
                  id="party"
                  name="party"
                  min="1900-01-01"
                  max="2099-01-01"
                  required
                />
              </div>
            </div>
            <!--BIO-->
            <div class="col-span-6 sm:col-span-4 sm:col-start-1 sm:col-end-5">
              <label for="bio" class="block text-sm font-medium text-gray-700">
                {$_(`pages.users.me.about_me`)}</label
              >
              <div class="mt-1">
                <textarea
                  bind:value={aboutInfo}
                  id="bio"
                  name="bio"
                  class=" shadow-sm focus:ring-indigo-500 focus:border-indigo-500 block w-full sm:text-sm border-gray-300 rounded-md"
                  style="height: 90px;"
                />
              </div>
            </div>
          </div>
        </div>

        <div class="bg-gray-50 px-4 py-3 text-right sm:px-6">
          <button
            type="button"
            class="inline-flex justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
            on:click|preventDefault={submitUserData}
          >
            {$_(`pages.users.me.save`)}
          </button>
        </div>
      </div>
    </form>
    <img src={avatar} alt="avatar" />
  </div>
</div>
