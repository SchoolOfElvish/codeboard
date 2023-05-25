<script lang="ts">
  import { locale, locales } from 'svelte-i18n';
  import { isLoading } from 'svelte-i18n';

  function handleChange(event: Event) {
    const selectedLocale = (event.target as HTMLSelectElement).value;
    localStorage.setItem('locale', selectedLocale);
  }

  if ($locale != null && $locale != undefined && $locale.startsWith('ru')) {
    $locale = 'ru';
  } else {
    $locale = 'en';
  }
</script>

{#if $isLoading}
  <p>Loading</p>
{:else}
  <div>
    <select
      bind:value={$locale}
      on:change={handleChange}
      class="mt-2 block rounded-md border-gray-300 py-2 px-3 pl-3 pr-10 text-gray-300 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-gray-600 sm:text-sm(4px) sm:leading-6 bg-gray-800 h-7 mx-auto"
    >
      {#each $locales as locale}
        <option class="hover:bg-gray-600 hover: text-white sm:text-sm(4px)" value={locale}>
          {locale}
        </option>
      {/each}
    </select>
  </div>
{/if}
