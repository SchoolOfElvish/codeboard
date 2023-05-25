<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import type { UserMenuItem } from './Desktop.svelte';
  import LanguageSwitcher from '$components/common/LanguageSwitcher.svelte';
  export let items: UserMenuItem[] = [];
</script>

<div class="border-t border-gray-700 pt-4 pb-3">
  <div class="flex items-center px-5">
    <div class="flex-shrink-0">
      <img
        class="h-10 w-10 rounded-full"
        src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
        alt=""
      />
    </div>

    <div class="ml-3">
      <div class="text-base font-medium leading-none text-white">Tom Cook</div>
      <div class="text-sm font-medium leading-none text-gray-400">tom@example.com</div>
    </div>
    <button
      type="button"
      class="ml-auto flex-shrink-0 rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
    >
      <span class="sr-only">View notifications</span>
      <Icon name="Bell" />
    </button>
  </div>

  <div class="mt-3 space-y-1 px-2">
    {#each items as userItem}
      {#if userItem.action}
        <button
          on:click={userItem.action}
          class="block rounded-md px-3 py-2 text-base font-medium text-gray-400 hover:bg-gray-700 hover:text-white"
        >
          {userItem.name}
        </button>
      {:else}
        <a
          href={userItem.href}
          class="block rounded-md px-3 py-2 text-base font-medium text-gray-400 hover:bg-gray-700 hover:text-white"
        >
          {userItem.name}
        </a>
      {/if}
    {/each}
  </div>
  <div class="ml-4">
    <LanguageSwitcher />
  </div>
</div>
