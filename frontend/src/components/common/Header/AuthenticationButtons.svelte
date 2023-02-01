<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { to } from '$lib/routes';
</script>

<!-- secondary link without background (not button but text) -->
<a
  href="/"
  class="relative inline-flex items-center rounded-md px-4 py-2 text-sm font-medium shadow-sm text-gray-300 hover:text-white focus:outline-none"
>
  <span>
    {$_('navbar.sign_in')}
  </span>
</a>
<a
  href={to.signUp()}
  class="relative inline-flex items-center rounded-md border border-transparent bg-indigo-500 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-600 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2 focus:ring-offset-gray-800"
>
  <span>
    {$_('navbar.sign_up')}
  </span>
</a>
