<script lang="ts">
  import { del, get } from '$utils/fetch';
  import { to } from '$lib/routes';
  import { _ } from 'svelte-i18n';

  let errors: Error = {};

  type Error = {
    [key: string]: string;
  };

  const logOut = async () => {
    const result = await del('/v1/sign-out');

    const response = await result
      .error(422, async (error) => {
        errors = JSON.parse(error.message).error;
        error;
      })
      .json<ResponseData>();

    if (response) { 
      if (response.ok) {
        window.location.href = to.root();
      }
    }
  };

  const testOut = async () => {
    const result = await get('/v1/sign-out');

    const response = await result
      .error(422, async (error) => {
        errors = JSON.parse(error.message).error;
        error;
      })
      .json<ResponseData>();

    if (response) { 
      if (response.ok) {
        window.location.href = to.root();
      }
    }
  };

  const testDel = async () => {
    const result = await fetch('/api/v1/sign-out',{ method: 'DELETE' });

    const response = await result
      .error(422, async (error) => {
        errors = JSON.parse(error.message).error;
        error;
      })
      .json<ResponseData>();

    if (response) { 
      if (response.ok) {
        window.location.href = to.root();
      }
    }
  };
</script>

<div class="flex min-h-full flex-col py-20 sm:px-6 lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-md">
    <img
      class="mx-auto h-12 w-auto"
      src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"
      alt="Your Company"
    />
    <h2 class="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900">
      {$_('Sign out')}
    </h2>
  </div>

  <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
    {#if Object.keys(errors).length > 0}
      <div role="alert" class="rounded border-l-4 border-red-500 bg-red-100 p-3 mb-2">
        <strong class="block font-medium text-red-700"> Something went wrong </strong>

        <p class="mt-2 text-sm text-red-700">
          {$_(`pages.sign_out.errors.${errors}`)}
        </p>
      </div>
    {/if}

    <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
      <form class="space-y-6">
        <div>
          <button
            type="submit"
            on:click={logOut}
            class="flex w-full justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
            >{$_('Sign Out')}</button
          >
        </div>
      </form>
    </div>
    <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
      <form class="space-y-6">
        <div>
          <button
            type="submit"
            on:click={testOut}
            class="flex w-full justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
            >{$_('Test Get')}</button
          >
        </div>
      </form>
    </div>
    <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
      <form class="space-y-6">
        <div>
          <button
            type="submit"
            on:click={testDel}
            class="flex w-full justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
            >{$_('Test Delete')}</button
          >
        </div>
      </form>
    </div>
  </div>
</div>
