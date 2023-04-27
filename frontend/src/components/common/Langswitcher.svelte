<script lang-ts>
  import { locale, locales } from 'svelte-i18n';
  import { isLoading } from 'svelte-i18n';

  export function handleChange(event) {
    const selectedLocale = event.target.value;
    localStorage.setItem('locale', selectedLocale);
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
