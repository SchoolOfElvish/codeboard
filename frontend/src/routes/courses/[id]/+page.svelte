<script lang="ts">
  import { _ } from 'svelte-i18n';
  import type { PageData } from './$types';
  export let data: PageData;
  import { writable } from 'svelte/store';

  let { name: courseName, user: courseAuthor, id: courseId } = data.response_course;

  let lessons = writable(data.response_lessons);
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">{courseName}</h1>
    <p class="hidden text-gray-500 sm:mt-4 sm:block">
      {courseAuthor.first_name}
      {courseAuthor.last_name}
    </p>
  </div>
</div>

{#if $lessons.length === 0}
  <div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
    <p>{$_(`pages.course.lessons_not_found`)}</p>
  </div>
{:else}
  {#each $lessons as lesson}
    <article class="mx-auto max-w-7xl overflow-hidden rounded-lg border border-gray-100 shadow-sm">
      <div class="p-4 sm:p-6">
        <a href="/">
          <h3 class="text-lg font-medium text-gray-900">{lesson.title}</h3>
        </a>

        <p class="mt-2 text-sm leading-relaxed text-gray-500 line-clamp-3">
          {$_(`pages.course.lesson_description`)}: {lesson.description}
        </p>

        <a
          href="/"
          class="group mt-4 inline-flex items-center gap-1 text-sm font-medium text-blue-600"
        >
          {$_(`pages.course.lesson_find`)}

          <span aria-hidden="true" class="block transition group-hover:translate-x-0.5">
            &rarr;
          </span>
        </a>
      </div>
    </article>
  {/each}
{/if}
<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  <button
    type="submit"
    on:click={() => (window.location.href = `/courses/${courseId}/lessons/new`)}
    class="inline-block rounded-lg bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
  >
    {$_('pages.course.add_lesson')}
  </button>
</div>
