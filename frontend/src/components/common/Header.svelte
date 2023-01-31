<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import { page } from '$app/stores';
  import { to } from '$lib/routes';
  import { _ } from 'svelte-i18n';
  import { locale } from 'svelte-i18n';
  import { Transition } from '@rgossiaux/svelte-headlessui';
  import user from '$stores/user';

  import * as Profile from './Header/Profile';
  import type { UserMenuItem } from './Header/Profile/Desktop.svelte';
  import AuthenticationButtons from './Header/AuthenticationButtons.svelte';

  $: if ($locale == 'en-GB') {
    $locale = 'en';
  }

  const menuItems = user.isAuthorized
    ? [
        {
          name: $_('navbar.menu.dashboard'),
          href: '/'
        },
        {
          name: $_('navbar.menu.my_courses'),
          href: to.courses.my()
        },
        {
          name: $_('navbar.menu.create_course'),
          href: to.courses.new()
        },
        {
          name: $_('navbar.menu.create_group'),
          href: to.groups.new()
        }
      ]
    : [];

  const userMenuItems: UserMenuItem[] = [
    {
      name: $_('navbar.user_menu.profile'),
      href: '/'
    },
    {
      name: $_('navbar.user_menu.settings'),
      href: '/'
    },
    {
      name: $_('navbar.user_menu.logout'),
      href: '/'
    }
  ];

  let isMobileMenuOpen = false;
</script>

<nav class="bg-gray-800">
  <div class="mx-auto max-w-7xl px-4 sm:px-6 lg:px-8">
    <div class="flex h-16 items-center justify-between">
      <div class="flex items-center">
        <div class="flex-shrink-0">
          <img
            class="h-8 w-8"
            src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=500"
            alt="Your Company"
          />
        </div>
        <div class="hidden md:block">
          <div class="ml-10 flex items-baseline space-x-4">
            {#each menuItems as item}
              <a
                href={item.href}
                class:current={$page.route.id === item.href}
                class="text-gray-300 hover:bg-gray-700 hover:text-white px-3 py-2 rounded-md text-sm font-medium"
                aria-current={item.href === $page.route.id ? 'page' : undefined}
              >
                {item.name}
              </a>
            {/each}
          </div>
        </div>
      </div>
      <!-- <select -->
      <!-- 	bind:value={$locale} -->
      <!-- 	class="mt-1 block w-32 rounded-md border-gray-300 py-2 pl-3 pr-10 text-base focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm" -->
      <!-- > -->
      <!-- 	{#each $locales as sel_locale} -->
      <!-- 		<option value={sel_locale}>{sel_locale}</option> -->
      <!-- 	{/each} -->
      <!-- </select> -->
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

            <!--
Dropdown menu, show/hide based on menu state.

Entering: "transition ease-out duration-100"
From: "transform opacity-0 scale-95"
To: "transform opacity-100 scale-100"
Leaving: "transition ease-in duration-75"
From: "transform opacity-100 scale-100"
To: "transform opacity-0 scale-95"
-->
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
                <!-- Active: "bg-gray-100", Not Active: "" -->
                <a
                  href="/users/me"
                  class="block px-4 py-2 text-sm text-gray-700"
                  role="menuitem"
                  tabindex="-1"
                  id="user-menu-item-0">Your Profile</a
                >

                <a
                  href="#"
                  class="block px-4 py-2 text-sm text-gray-700"
                  role="menuitem"
                  tabindex="-1"
                  id="user-menu-item-1">Settings</a
                >

                <a
                  href="#"
                  class="block px-4 py-2 text-sm text-gray-700"
                  role="menuitem"
                  tabindex="-1"
                  id="user-menu-item-2">Sign out</a
                >
              </div>
            </Transition>
          </div>
        </div>
      {/if}
      <div class="-mr-2 flex md:hidden">
        <!-- Mobile menu button -->
        <button
          type="button"
          on:click={() => {
            isMobileMenuOpen = !isMobileMenuOpen;
          }}
          class="inline-flex items-center justify-center rounded-md bg-gray-800 p-2 text-gray-400 hover:bg-gray-700 hover:text-white focus:outline-none focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-gray-800"
          aria-controls="mobile-menu"
          aria-expanded="false"
        >
          <span class="sr-only">Open main menu</span>
          {#if isMobileMenuOpen}
            <Icon name="XMark" classes="block h-6 w-6" />
          {:else}
            <Icon name="Bars3" classes="block h-6 w-6" />
          {/if}
        </button>
      </div>
    </div>
  </div>

  <!-- Mobile menu, show/hide based on menu state. -->
  <Transition show={isMobileMenuOpen}>
    <div class="md:hidden" id="mobile-menu">
      <div class="space-y-1 px-2 pt-2 pb-3 sm:px-3">
        {#each menuItems as item}
          <a
            href={item.href}
            class:current={$page.route.id === item.href}
            class="text-gray-300 hover:bg-gray-700 hover:text-white block px-3 py-2 rounded-md text-base font-medium"
            aria-current={item.href === $page.route.id ? 'page' : undefined}
          >
            {item.name}
          </a>
        {/each}
      </div>
      {#if user.isAuthorized}
        <Profile.Mobile items={userMenuItems} />
      {:else}
        <div class="border-t border-gray-700 p-5">
          <AuthenticationButtons />
        </div>
      {/if}
    </div>
  </Transition>
</nav>

<style lang="postcss">
  .current {
    @apply bg-gray-900 text-white;
  }
</style>
