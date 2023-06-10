<script lang="ts">
  import { page } from '$app/stores';
  import { post } from '$utils/fetch';
  import { _ } from 'svelte-i18n';

  let title = '';
  let description = '';

  let status: OperationStatus = 'incompleted';
  let errors: Error = {};

  type OperationStatus = 'success' | 'failure' | 'incompleted';
  type Error = {
    [key: string]: string[];
  };

  const createLesson = async () => {
    const result = await post(`/v1/courses/${$page.params.id}/lessons`, {
      title,
      description
    });

    result
      .error(422, async (error) => {
        errors = JSON.parse(error.message).errors;
        status = 'failure';
        console.log(JSON.parse(error.message));
        return error;
      })
      .res(() => (status = 'success'));
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
    <h1 class="text-2xl font-bold sm:text-3xl">{$_(`pages.create_lesson.create_lesson`)}</h1>
  </div>

  <form action="" class="mx-auto mt-8 mb-0 max-w-md space-y-4">
    <div>
      <label for="title" class="sr-only">{$_(`pages.create_lesson.title`)}</label>

      <div class="relative ">
        <input
          minlength="4"
          bind:value={title}
          type="text"
          class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
          placeholder={$_(`pages.create_lesson.enter_title`)}
        />
      </div>
    </div>

    <div>
      <label for="descriptoin" class="sr-only">{$_(`pages.create_lesson.description`)}</label>
      <div class="relative">
        <input
          bind:value={description}
          type="text-area"
          maxlength="255"
          class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
          placeholder={$_(`pages.create_lesson.enter_description`)}
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
       {$_(`pages.create_lesson.create_lesson_button`)}
      </button>
    </div>
  </form>
</div>

<style>
</style>
