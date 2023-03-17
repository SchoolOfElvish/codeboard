<script lang="ts">
  import { del } from '$utils/fetch';
  import { to } from '$lib/routes';
  import { onMount } from 'svelte';
  import { _ } from 'svelte-i18n';

  let errors: Error = {};

  type Error = {
    [key: string]: string;
  };

  onMount (async () => {
    const result = await del('/v1/sign-out');
    localStorage.removeItem('user');
    
    const response = await result
      .error(422, async (error) => {
        errors = JSON.parse(error.message).error;
        error;
      })    
  });

  onMount(async () => {
		window.location.href = to.signIn();
	});
</script>

<div class="flex min-h-full flex-col py-20 sm:px-6 lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-md">
    <img
      class="mx-auto h-12 w-auto"
      src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"
      alt="Your Company"
    />
    <h2 class="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900">
      {$_('pages.sign_out.title')}
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
      {$_('pages.sign_out.fillers_text')}
    </div>
  </div>
</div>
