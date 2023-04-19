<script lang="ts">
  import notifications from '$stores/notifications';
  import Icon from '$components/icons/Icon.svelte';

  function showSuccessNotification() {
    notifications.success({
      message: 'Success notification!',
      description: 'This is a success notification example.'
    });
  }

  function showErrorNotification() {
    notifications.error({
      message: 'Error notification!',
      description: 'This is an error notification example.'
    });
  }

  function showWarningNotification() {
    notifications.warning({
      message: 'Warning notification!',
      description: 'This is a warning notification example.'
    });
  }

  function showInfoNotification() {
    notifications.info({
      message: 'Warning notification!',
      description: 'This is a warning notification example.'
    });
  }
</script>

<div class="flex space-x-4">
  <button class="px-4 py-2 bg-green-500 text-white rounded" on:click={showSuccessNotification}>
    Show Success Notification
  </button>
  <button class="px-4 py-2 bg-red-500 text-white rounded" on:click={showErrorNotification}>
    Show Error Notification
  </button>
  <button class="px-4 py-2 bg-yellow-500 text-white rounded" on:click={showWarningNotification}>
    Show Warning Notification
  </button>
  <button class="px-4 py-2 bg-blue-500 text-white rounded" on:click={showInfoNotification}>
    Show Info Notification
  </button>
</div>
<div
  class="pointer-events-none fixed inset-0 flex items-end px-4 py-20 sm:items-start bg-opacity-25"
>
  <div class="flex w-full flex-col items-center sm:items-end">
    {#each $notifications as notification}
      <div
        class="pointer-events-auto w-full max-w-sm overflow-hidden rounded-lg bg-white shadow-lg ring-1 ring-black ring-opacity-5"
      >
        <div class="p-4">
          <div class="flex items-start">
            <div class="flex-shrink-0">
              {#if notification.type === 'success'}
                <Icon name="CheckCircle" />
              {:else if notification.type === 'error'}
                <Icon name="ExclamationCircle" />
              {:else if notification.type === 'warning'}
                <Icon name="QuestionMarkCircle" />
              {:else}
                <Icon name="InformationCircle" />
              {/if}
            </div>
            <div class="ml-3 w-0 flex-1 pt-0.5">
              <p class="text-sm font-medium text-gray-900">{notification.message}</p>
              <p class="mt-1 text-sm text-gray-500">{notification.description}.</p>
            </div>
            <div class="ml-4 flex flex-shrink-0">
              <button
                type="button"
                class="inline-flex rounded-md bg-white text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
              >
                <span class="sr-only">Close</span>
                <svg class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                  <path
                    d="M6.28 5.22a.75.75 0 00-1.06 1.06L8.94 10l-3.72 3.72a.75.75 0 101.06 1.06L10 11.06l3.72 3.72a.75.75 0 101.06-1.06L11.06 10l3.72-3.72a.75.75 0 00-1.06-1.06L10 8.94 6.28 5.22z"
                  />
                </svg>
              </button>
            </div>
          </div>
        </div>
      </div>
    {/each}
  </div>
</div>
