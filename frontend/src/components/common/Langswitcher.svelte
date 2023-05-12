<script lang="ts">
  import Alert from '$components/Alert.svelte';
  import { locale, locales } from 'svelte-i18n';
  import { isLoading } from 'svelte-i18n';


  $: if ($locale.startsWith('ru')) {
    $locale = 'ru';
  }
  else {$locale = 'en'}


interface NumberEvent extends CustomEvent<string> {}

function handleChange(event: NumberEvent) {
console.log(event.type); 
const selectedLocale = event.detail; 
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
