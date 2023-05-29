<script context="module" lang="ts">
  export type UserMenuItem = {
    name: string;
    href?: string;
    action?: () => void;
  };

  export type MenuItemWithPrefetch = UserMenuItem & {
    dataSveltekitPrefetch?: boolean;
  };
</script>

<script lang="ts">
  import { Transition } from '@rgossiaux/svelte-headlessui';
  import Icon from '$components/icons/Icon.svelte';

  export let items: UserMenuItem[] = [];
  let isDropdownOpen = false;
</script>

<div class="hidden md:block">
  <div class="ml-4 flex items-center md:ml-6">
    <button
      type="button"
      class="rounded-full bg-gray-800 p-1 text-gray-400 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
    >
      <span class="sr-only">View notifications</span>
      <Icon name="Bell" />
    </button>

    <!-- Profile dropdown -->
    <div class="relative ml-3">
      <div>
        <button
          type="button"
          class="flex max-w-xs items-center rounded-full bg-gray-800 text-sm focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
          on:click={() => {
            isDropdownOpen = !isDropdownOpen;
          }}
          id="user-menu-button"
          aria-expanded="false"
          aria-haspopup="true"
        >
          <span class="sr-only">Open user menu</span>
          <img
            class="h-8 w-8 rounded-full"
            src="https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
            alt=""
          />
        </button>
      </div>

      <Transition
        show={isDropdownOpen}
        enter="transition ease-out duration-100"
        enterFrom="transform opacity-0 scale-95"
        enterTo="transform opacity-100 scale-100"
        leave="transition ease-in duration-75"
        leaveFrom="transform opacity-100 scale-100"
        leaveTo="transform opacity-0 scale-95"
      >
        <div
          class="absolute right-0 z-10 mt-2 w-48 origin-top-right rounded-md bg-white py-1 shadow-lg ring-1 ring-black ring-opacity-5 focus:outline-none"
          role="menu"
          aria-orientation="vertical"
          aria-labelledby="user-menu-button"
          tabindex="-1"
        >
          {#each items as userItem, index}
            {#if userItem.action}
              <button
                type="button"
                class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
                role="menuitem"
                tabindex="-1"
                id="user-menu-item-{index}"
                on:click={userItem.action}
              >
                {userItem.name}
              </button>
            {:else}
              <a
                href={userItem.href}
                class="block w-full text-left px-4 py-2 text-sm text-gray-700 hover:bg-gray-100 hover:text-gray-900"
                role="menuitem"
                tabindex="-1"
                id="user-menu-item-{index}"
              >
                {userItem.name}
              </a>
            {/if}
          {/each}
        </div>
      </Transition>
    </div>
  </div>
</div>
