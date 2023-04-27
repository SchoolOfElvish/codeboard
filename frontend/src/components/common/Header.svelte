<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import { page } from '$app/stores';
  import { to } from '$lib/routes';
  import { _ } from 'svelte-i18n';
  import { locale } from 'svelte-i18n';
  import { Transition } from '@rgossiaux/svelte-headlessui';
  import user from '$stores/user';
  import { del } from '$utils/fetch';

  import * as Profile from './Header/Profile';
  import type { UserMenuItem } from './Header/Profile/Desktop.svelte';
  import AuthenticationButtons from './Header/AuthenticationButtons.svelte';

  $: if ($locale == 'en-GB') {
    $locale = 'en';
  }

  const logOut = async () => {
    await del('/v1/sign-out');
    localStorage.removeItem('user');
    window.location.href = to.signIn();
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
      href: '/users/me'
    },
    {
      name: $_('navbar.user_menu.settings'),
      href: '/'
    },
    {
      name: $_('navbar.user_menu.logout'),
      action: logOut
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
      {#if user.isAuthorized}
        <Profile.Desktop items={userMenuItems} />
      {:else}
        <div class="hidden md:block">
          <AuthenticationButtons />
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
