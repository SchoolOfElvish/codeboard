<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import { post } from '$utils/fetch';

  let name = '';
  let isSuccess = false;
  let errorMessage = '';

  const handleSubmit = async () => {
    const result = await post('/v1/courses', { name });
    const response = await result.res();

    if (response.status === 201) {
      isSuccess = true;
    } else if (response.status === 422) {
      isSuccess = true;
      errorMessage = response.error.message;
    }
  };

  const closeAlert = () => {
    isSuccess = false;
    errorMessage = '';
  };
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  {#if isSuccess}
    {#if errorMessage != ''}
      <div class="rounded-md bg-red-50 p-4">
        <div class="flex">
          <div class="flex-shrink-0">
            <Icon name="XCircle" />
          </div>
          <div class="ml-3">
            <p class="text-sm font-medium text-red-800">{errorMessage}</p>
          </div>
          <div class="ml-auto pl-3">
            <div class="-mx-1.5 -my-1.5">
              <button
                type="button"
                class="inline-flex rounded-md bg-red-50 p-1.5 text-red-500 hover:bg-red-100 focus:outline-none focus:ring-2 focus:ring-red-600 focus:ring-offset-2 focus:ring-offset-red-50"
                on:click|preventDefault={closeAlert}
              >
                <span class="sr-only">Dismiss</span>
                <Icon name="XMark" />
              </button>
            </div>
          </div>
        </div>
      </div>
    {:else}
      <div class="rounded-md bg-green-50 p-4">
        <div class="flex">
          <div class="flex-shrink-0">
            <Icon name="CheckCircle" />
          </div>
          <div class="ml-3">
            <p class="text-sm font-medium text-green-800">Course created!</p>
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
  {/if}

  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">Create course:</h1>
  </div>

  <form class="mx-auto mt-8 mb-0 max-w-md space-y-4">
    <div>
      <label for="title" class="sr-only">title</label>
      <div class="relative ">
        <input
          bind:value={name}
          type="text"
          class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
          placeholder="Enter course title"
        />
      </div>
    </div>

    <div class="flex items-center justify-between">
      <button
        on:click|preventDefault={handleSubmit}
        type="submit"
        class="inline-block rounded-lg bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
      >
        Create course
      </button>
    </div>
  </form>
</div>
