<script lang="ts">
  import { _ } from 'svelte-i18n';
  import type { ActionData } from './$types';
  import notifications from '$stores/notifications';

  export let form: ActionData;

  if (form?.errors) {
    const errors = form.errors;

    notifications.error({
      message: 'Error!',
      description: errors
    });
  }
  if (form?.success) {
    notifications.success({
      message: 'Success!',
      description: 'Group created'
    });
  }
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-18">
  <div class="mx-auto max-w-lg p-3" />
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">{$_('pages.create_group.create_group')}</h1>
  </div>

  <form method="POST" class="mx-auto mt-8 mb-0 max-w-md space-y-4">
    <div>
      <label for="name" class="sr-only">name</label>
      <div class="relative ">
        <input
          name="name"
          minlength="4"
          type="text"
          class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
          placeholder={$_('pages.create_group.title')}
        />
      </div>
    </div>

    <div>
      <label for="descriptoin" class="sr-only">email</label>
      <div class="relative">
        <input
          name="email"
          type="email"
          maxlength="255"
          class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
          placeholder={$_('pages.create_group.email')}
        />
      </div>
    </div>
    <div class="flex items-center justify-between">
      <button
        type="submit"
        class="inline-block rounded-lg bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
      >
        {$_('pages.create_group.create_button')}
      </button>
    </div>
  </form>
</div>
