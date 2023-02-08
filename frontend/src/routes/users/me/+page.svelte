<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import user from '$stores/user';
  import wretch from 'wretch';

  const api = wretch('http://localhost:3000/api');

  let birthdate: string;
  let isSuccess = false;

  const submitBirthdate = async () => {
    const response = await api
      .url('/v1/users/me')
      .headers({ Authorization: `Bearer ${$user.token}` })
      .post({ birthdate });

    if (response) {
      isSuccess = true;
    }
  };

  const closeAlert = () => {
    isSuccess = false;
  };
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
        <Icon name="UserCircle" />
        <span class="truncate">Account</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/key -->
        <Icon name="Key" />
        <span class="truncate">Password</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/credit-card -->
        <Icon name="CreditCard" />
        <span class="truncate">Plan &amp; Billing</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/user-group -->
        <Icon name="UserGroup" />
        <span class="truncate">Team</span>
      </a>

      <a
        href="#"
        class="text-gray-900 hover:text-gray-900 hover:bg-gray-50 group rounded-md px-3 py-2 flex items-center text-sm font-medium"
      >
        <!-- Heroicon name: outline/squares-plus -->
        <Icon name="SquaresPlus" />
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
                <!-- Heroicon name: mini/x-mark -->
                <svg
                  class="h-5 w-5"
                  xmlns="http://www.w3.org/2000/svg"
                  viewBox="0 0 20 20"
                  fill="currentColor"
                  aria-hidden="true"
                >
                  <path
                    d="M6.28 5.22a.75.75 0 00-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 101.06 1.06L10 11.06l3.72 3.72a.75.75 0 101.06-1.06L11.06 10l3.72-3.72a.75.75 0 00-1.06-1.06L10 8.94 6.28 5.22z"
                  />
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
                <h3 class="text-lg font-medium leading-6 text-gray-900">Input your birthdate</h3>
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
                        type="button"
                        class="inline-flex items-center rounded-md border border-transparent bg-indigo-600 px-4 py-2 text-base font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
                        on:click|preventDefault={submitBirthdate}
                      >
                        Submit
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
