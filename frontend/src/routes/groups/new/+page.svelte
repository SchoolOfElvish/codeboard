<script lang="ts">
  import { post } from '$utils/fetch';
  import Icon from '$components/icons/Icon.svelte';
  import { _ } from 'svelte-i18n';

  type OperationStatus = 'success' | 'failure' | 'incompleted';

  let name: string;
  let email: string;
  let status: OperationStatus = 'incompleted';
  let errors: Error = {};
  type Error = {
    [key: string]: string[];
  };

  const createGroup = async () => {
    const result = await post('/v1/groups', {
      name: name
    });

    result
      .error(422, async (error) => {
        errors = JSON.parse(error.message).errors;
        status = 'failure';
        console.log(JSON.parse(error.message));
        return error;
      })
      .res(() => (status = 'success'));
  };

  const closeAlert = () => {
    status = 'incompleted';
  };
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-18">
  <div class="mx-auto max-w-lg p-3">
    {#if status === 'failure'}
      {#if Object.keys(errors).length > 0}
        <div role="alert" class="rounded border-l-4 border-red-500 bg-red-50 p-4">
          <strong class="block font-medium text-red-700">
            {$_('pages.create_group.something_went_wrong')}
          </strong>
          <p class="mt-2 text-sm text-red-700">
            {#each Object.keys(errors) as key}
              {#if key === 'name'}
                {$_('pages.create_group.errors.title')}
              {:else}
                {key}: {errors[key].join(', ')}
              {/if}
              <br />
            {/each}
          </p>
        </div>
      {/if}
    {:else if status === 'success'}
      <div class="rounded-md bg-green-100 p-4">
        <div class="flex">
          <div class="flex-shrink-0">
            <Icon name="CheckCircle" />
          </div>
          <div class="ml-3">
            <p class="text-sm font-medium text-green-800">
              {$_('pages.create_group.success_message')}
            </p>
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
  </div>
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">{$_('pages.create_group.create_group')}</h1>
  </div>

  <form action="" class="mx-auto mt-8 mb-0 max-w-md space-y-4">
    <div>
      <label for="name" class="sr-only">name</label>
      <div class="relative ">
        <input
          bind:value={name}
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
          bind:value={email}
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
        on:click={createGroup}
        class="inline-block rounded-lg bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
      >
        {$_('pages.create_group.create_button')}
      </button>
    </div>
  </form>
</div>
