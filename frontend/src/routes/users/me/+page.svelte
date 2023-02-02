<script lang="ts">
  import user from '$stores/user';
  import wretch from 'wretch';

  const api = wretch('http://localhost:3000/api');

  let birthdate:string;
  let isSuccess = false;
  $: console.log(birthdate);
  $: console.log(isSuccess);
  $: isSuccess;

  const submitBirthdate = async () => {
    const response = await api
      .url('/v1/users/me')
      .headers({'Authorization':`Bearer ${$user.token}`})
      .post({birthdate})

    if(response){
      isSuccess = true;
    }
  }
</script>

<div class="lg:grid lg:grid-cols-12 lg:gap-x-5 container mx-auto mt-2">
  <aside class="py-6 px-2 sm:px-6 lg:col-span-3 lg:py-0 lg:px-0">
    <nav class="space-y-1">
      <!-- Current: "bg-gray-50 text-indigo-700 hover:text-indigo-700 hover:bg-white", Default: "text-gray-900 hover:text-gray-900 hover:bg-gray-50" -->
      <a
        href="#"
        class="bg-gray-50 text-indigo-700 hover:text-indigo-700 hover:bg-white group rounded-md px-3 py-2 flex items-center text-sm font-medium"
        aria-current="page"
      >
        <!--
          Heroicon name: outline/user-circle

          Current: "text-indigo-500 group-hover:text-indigo-500", Default: "text-gray-400 group-hover:text-gray-500"
        -->
        <svg
          class="text-indigo-500 group-hover:text-indigo-500 flex-shrink-0 -ml-1 mr-3 h-6 w-6"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M17.982 18.725A7.488 7.488 0 0012 15.75a7.488 7.488 0 00-5.982 2.975m11.963 0a9 9 0 10-11.963 0m11.963 0A8.966 8.966 0 0112 21a8.966 8.966 0 01-5.982-2.275M15 9.75a3 3 0 11-6 0 3 3 0 016 0z"
          />
        </svg>
        <span class="truncate">Account</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/key -->
        <svg
          class="text-gray-400 group-hover:text-gray-500 flex-shrink-0 -ml-1 mr-3 h-6 w-6"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M15.75 5.25a3 3 0 013 3m3 0a6 6 0 01-7.029 5.912c-.563-.097-1.159.026-1.563.43L10.5 17.25H8.25v2.25H6v2.25H2.25v-2.818c0-.597.237-1.17.659-1.591l6.499-6.499c.404-.404.527-1 .43-1.563A6 6 0 1121.75 8.25z"
          />
        </svg>
        <span class="truncate">Password</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/credit-card -->
        <svg
          class="text-gray-400 group-hover:text-gray-500 flex-shrink-0 -ml-1 mr-3 h-6 w-6"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M2.25 8.25h19.5M2.25 9h19.5m-16.5 5.25h6m-6 2.25h3m-3.75 3h15a2.25 2.25 0 002.25-2.25V6.75A2.25 2.25 0 0019.5 4.5h-15a2.25 2.25 0 00-2.25 2.25v10.5A2.25 2.25 0 004.5 19.5z"
          />
        </svg>
        <span class="truncate">Plan &amp; Billing</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/user-group -->
        <svg
          class="text-gray-400 group-hover:text-gray-500 flex-shrink-0 -ml-1 mr-3 h-6 w-6"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M18 18.72a9.094 9.094 0 003.741-.479 3 3 0 00-4.682-2.72m.94 3.198l.001.031c0 .225-.012.447-.037.666A11.944 11.944 0 0112 21c-2.17 0-4.207-.576-5.963-1.584A6.062 6.062 0 016 18.719m12 0a5.971 5.971 0 00-.941-3.197m0 0A5.995 5.995 0 0012 12.75a5.995 5.995 0 00-5.058 2.772m0 0a3 3 0 00-4.681 2.72 8.986 8.986 0 003.74.477m.94-3.197a5.971 5.971 0 00-.94 3.197M15 6.75a3 3 0 11-6 0 3 3 0 016 0zm6 3a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0zm-13.5 0a2.25 2.25 0 11-4.5 0 2.25 2.25 0 014.5 0z"
          />
        </svg>
        <span class="truncate">Team</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/squares-plus -->
        <svg
          class="text-gray-400 group-hover:text-gray-500 flex-shrink-0 -ml-1 mr-3 h-6 w-6"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke-width="1.5"
          stroke="currentColor"
          aria-hidden="true"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            d="M13.5 16.875h3.375m0 0h3.375m-3.375 0V13.5m0 3.375v3.375M6 10.5h2.25a2.25 2.25 0 002.25-2.25V6a2.25 2.25 0 00-2.25-2.25H6A2.25 2.25 0 003.75 6v2.25A2.25 2.25 0 006 10.5zm0 9.75h2.25A2.25 2.25 0 0010.5 18v-2.25a2.25 2.25 0 00-2.25-2.25H6a2.25 2.25 0 00-2.25 2.25V18A2.25 2.25 0 006 20.25zm9.75-9.75H18a2.25 2.25 0 002.25-2.25V6A2.25 2.25 0 0018 3.75h-2.25A2.25 2.25 0 0013.5 6v2.25a2.25 2.25 0 002.25 2.25z"
          />
        </svg>
        <span class="truncate">Integrations</span>
      </a>
    </nav>
  </aside>

  <div class="space-y-2 sm:px-6 lg:col-span-9 lg:px-0">
    {#if isSuccess == true}
    <div class="rounded-md bg-green-50 p-4">
      <div class="flex">
        <div class="flex-shrink-0">
          <!-- Heroicon name: mini/check-circle -->
          <svg class="h-5 w-5 text-green-400" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.857-9.809a.75.75 0 00-1.214-.882l-3.483 4.79-1.88-1.88a.75.75 0 10-1.06 1.061l2.5 2.5a.75.75 0 001.137-.089l4-5.5z" clip-rule="evenodd" />
          </svg>
        </div>
        <div class="ml-3">
          <p class="text-sm font-medium text-green-800">Successfully uploaded</p>
        </div>
        <div class="ml-auto pl-3">
          <div class="-mx-1.5 -my-1.5">
            <button type="button" class="inline-flex rounded-md bg-green-50 p-1.5 text-green-500 hover:bg-green-100 focus:outline-none focus:ring-2 focus:ring-green-600 focus:ring-offset-2 focus:ring-offset-green-50">
              <span class="sr-only">Dismiss</span>
              <!-- Heroicon name: mini/x-mark -->
              <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path d="M6.28 5.22a.75.75 0 00-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 101.06 1.06L10 11.06l3.72 3.72a.75.75 0 101.06-1.06L11.06 10l3.72-3.72a.75.75 0 00-1.06-1.06L10 8.94 6.28 5.22z" />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>
  {/if}
    <form action="#" method="POST">
      <div class="shadow sm:overflow-hidden sm:rounded-md">
        <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
          <div>
            <h3 class="text-lg font-medium leading-6 text-gray-900">Profile</h3>
            <p class="mt-1 text-sm text-gray-500">
              This information will be displayed publicly so be careful what you share.
            </p>
          </div>
        </div>

        <!-- Datapicker -->

        <div class="space-y-6 sm:px-6 lg:col-span-9 lg:px-0">
          <div class="shadow sm:overflow-hidden sm:rounded-md">
            <div class="space-y-6 bg-white py-6 px-4 sm:p-6">
              <div>
                <h3 class="text-lg font-medium leading-6 text-gray-900">
                  Input your birthdate
                </h3>
                <form>
                  <div class="date-picker">
                    <input
                      bind:value={birthdate}
                      class="mt-1 rounded-md border-gray-300 shadow-sm focus:border-indigo-500 focus:ring-indigo-500 sm:text-sm"
                      type="date"
                      id="party"
                      name="party"
                      min="1900-01-01"
                      max="2099-01-01"
                      required
                    />
                    <div class="inline-block">
                      <button
                        type="submit"
                        class="mt-1 inline-block rounded-lg bg-green-500 px-5 py-3 text-sm font-medium text-white invalid:border-red-500"
                        on:click|preventDefault={submitBirthdate}
                      >
                        <span class="text-date-picker">Submit</span>
                      </button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>

      </div>
    </form>
  </div>
</div>
