<script>
  import '../app.css';
  import Header from '$components/common/Header.svelte';
  import Notifications from '$components/common/Notifications.svelte';
</script>

<Header />

<Notifications />
<slot />
