<script lang="ts">
  import '../app.css';
  import Header from '$components/common/Header.svelte';
  import Notifications from '$components/common/Notifications.svelte';
  import type { LayoutData } from './$types';

  export let data: LayoutData;
</script>

<Header user={data.user} />

<Notifications />
<slot />
