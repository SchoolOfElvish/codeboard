<script lang="ts">
  import Icon from '$components/icons/Icon.svelte';
  import { onMount } from 'svelte';
  import { locale, locales } from 'svelte-i18n';
  import { isLoading } from 'svelte-i18n';

  let isOpen = false;

  if ($locale && $locale.startsWith('ru')) {
    $locale = 'ru';
  } else {
    $locale = 'en';
  }

  function handleToggle() {
    isOpen = !isOpen;
  }

  function handleSelection(selectedLocale: string) {
    locale.set(selectedLocale);
    localStorage.setItem('locale', selectedLocale);
    isOpen = false;
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
  <div id="main" class="dropdown w-fit relative mt-2">
    <button
      type="button"
      class="flex p-1 rounded-md border-gray-300 text-gray-300 ring-inset ring-gray-300 focus:ring-2 
      focus:ring-gray-600 sm:text-sm(4px) sm:leading-6 bg-gray-800 bg-none hover:bg-gray-700 hover:text-white"
      on:click={handleToggle}
    >
      <Icon name="Globe" classes="h-6 w-6" />
      <span class="mx-1">{$locale}</span>
    </button>
    {#if isOpen}
      <div
        id="opener"
        class="absolute z-10 justify-center rounded-md shadow-lg bg-gray-700 mt-1 w-full"
      >
        {#each $locales as local}
          {#if $locale === local}
            <span />
          {:else}
            <button
              type="button"
              class="flex flex-col items-center justify-center w-full  px-4 py-2 text-gray-300 hover:bg-gray-700 rounded-md"
              on:click={() => handleSelection(local)}
            >
              {local}
            </button>
          {/if}
        {/each}
      </div>
    {/if}
  </div>
{/if}
