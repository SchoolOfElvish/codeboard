<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import { onMount } from 'svelte';
  import { locale, locales } from 'svelte-i18n';
  import { isLoading } from 'svelte-i18n';

  let isOpen = false;
  let currentLocale: string;

  if ($locale && $locale.startsWith('ru')) {
    currentLocale = 'ru';
  } else {
    currentLocale = 'en';
  }

  function handleToggle() {
    isOpen = !isOpen;
  }

  function handleSelection(locale: string) {
    currentLocale = locale;
    localStorage.setItem('locale', locale);
    isOpen = false;
  }

  $: {
    if (currentLocale.startsWith('ru')) {
      $locale = 'ru';
    } else {
      $locale = 'en';
    }
  }

  onMount(() => {
    const handleClickOutside = (event: MouseEvent) => {
      const target = event.target as HTMLElement;
      if (!target.closest('.dropdown')) {
        isOpen = false;
      }
    };

    window.addEventListener('click', handleClickOutside);

    return () => {
      window.removeEventListener('click', handleClickOutside);
    };
  });
</script>

{#if $isLoading}
  <p>Loading</p>
{:else}
  <div class="dropdown relative">
    <button
      type="button"
      class="mt-2 rounded-md border-gray-300 text-gray-300 ring-inset ring-gray-300 focus:ring-2 
           focus:ring-gray-600 sm:text-sm(4px) sm:leading-6 bg-gray-800 bg-none flex items-center hover:bg-gray-700 hover:text-white"
      on:click={handleToggle}
    >
      <Icon name="Key" classes="w-6 h-6" />
      <span class="hover:text-white">{$locale}</span>
    </button>
    {#if isOpen}
      <div class="absolute right-0 w-16 rounded-md shadow-lg bg-gray-700 mt-1">
        {#each $locales as locale}
          <button
            type="button"
            class="w-full px-4 py-2 text-sm text-gray-300 hover:bg-gray-600 rounded-md"
            on:click={() => handleSelection(locale)}
          >
            {locale}
          </button>
        {/each}
      </div>
    {/if}
  </div>
{/if}
