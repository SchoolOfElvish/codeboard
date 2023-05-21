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
      class="mt-2 block rounded-md border-0 py-1.5 pl-3 pr-10 text-gray-900 ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-indigo-600 sm:text-sm sm:leading-6"
    >
      {#each $locales as locale}
        <option class="hover:bg-indigo-600" value={locale}> {locale} </option>
      {/each}
    </select>
  </div>
{/if}
