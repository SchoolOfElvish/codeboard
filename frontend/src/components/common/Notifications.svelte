<script type="ts">
  import { onMount, onDestroy } from 'svelte';
  import notifications from '$stores/notifications';

  let notificationsList = [];

  const unsubscribe = notifications.subscribe((notificationsArray) => {
    notificationsList = notificationsArray;
  });

  function addSuccessNotification() {
    notifications.success({
      message: 'Success!',
      description: 'Your action was successful.'
    });
  }
  function addErrorNotification() {
    notifications.error({
      message: 'error!',
      description: 'Your action was error.'
    });
  }
  function addInfoNotification() {
    notifications.info({
      message: 'info!',
      description: 'Your action was info.'
    });
  }
  function addWarningNotification() {
    notifications.warning({
      message: 'warning!',
      description: 'Your action was warning.'
    });
  }

  
</script>

<div>
  <button on:click={addSuccessNotification}>success</button>
  <button on:click={addErrorNotification}>error</button>
  <button on:click={addInfoNotification}>info</button>
  <button on:click={addWarningNotification}>warning</button>
  <ul>
    {#each notificationsList as notification}
      <li>
        <h3>{notification.message}</h3>
        <p>{notification.description}</p>
      </li>
    {/each}
  </ul>
</div>
