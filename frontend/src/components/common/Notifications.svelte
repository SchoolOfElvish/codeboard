<script lang="ts">
  import notifications from '$stores/notifications';
  import Notification from '$components/common/Notification.svelte';
</script>

<div
  class="pointer-events-none fixed inset-0 flex items-end px-4 py-20 sm:items-start bg-opacity-25"
>
  <div class="flex w-full flex-col items-center sm:items-end">
    {#each $notifications as notification}
      <Notification
        type={notification.type}
        message={notification.message}
        description={notification.description}
      />
    {/each}
  </div>
</div>
