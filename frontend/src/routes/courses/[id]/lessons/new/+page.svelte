<script lang="ts">
  import { page } from '$app/stores';
  let title = '';
  let description = '';

  const createLesson = () => {
    fetch(`http://localhost:3000/api/v1/courses/${$page.params.id}/lessons/new`, {
      method: 'POST',
      body: JSON.stringify({ title, description })
    });
  };
  let isFormEmpty = true;
  const checkForm = (title: string, description: string) => {
    if (title == '' || description == '') {
      isFormEmpty = true;
    } else {
      isFormEmpty = false;
    }
  };
  $: checkForm(title, description);
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">Create lesson:</h1>
  </div>

  <form action="" class="mx-auto mt-8 mb-0 max-w-md space-y-4">
    <div>
      <label for="title" class="sr-only">title</label>

      <div class="relative ">
        <input
          minlength="4"
          bind:value={title}
          type="text"
          class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
          placeholder="Enter lesson title"
        />
      </div>
    </div>

    <div>
      <label for="descriptoin" class="sr-only">Desscription</label>
      <div class="relative">
        <input
          bind:value={description}
          type="text-area"
          maxlength="255"
          class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
          placeholder="Enter lesson description"
        />
      </div>
    </div>

    <div class="flex items-center justify-between">
      <button
        on:click={createLesson}
        disabled={isFormEmpty}
        type="submit"
        class="ml-3 inline-block rounded-lg bg-indigo-600 px-5 py-3 text-sm font-medium text-white"
      >
        Create Lesson
      </button>
    </div>
  </form>
</div>

<style>
</style>
