<script lang="ts">
  import { onMount } from 'svelte';
  import { writable } from 'svelte/store';
  import { get } from '$utils/fetch';
  import { _ } from 'svelte-i18n';
  import { page } from '$app/stores';
  import { to } from '$lib/routes';

  type Course = {
    name: string;
    user: {
      first_name: string;
      last_name: string;
    };
  };

  let courses = writable<Course[]>([]);
  let search = '';

  async function submitForm() {
    const query = encodeURIComponent(search.trim());
    to.courses.root({ search: query });

    fetchCourses();
  }

  async function getCourses() {
    const urlSearchParams = $page.url.searchParams;
    search = urlSearchParams.get('search') || '';

    fetchCourses();
  }

  async function fetchCourses() {
    const data = await (await get(`/v1/courses/guest?search=${search}`)).json<Course[]>();
    courses.set(data);
  }

  onMount(getCourses);
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">{$_(`pages.courses.title`)}</h1>
  </div>
  <div class="mx-auto mt-8 max-w-xl">
    <form on:submit|preventDefault={submitForm} class="sm:flex sm:gap-4">
      <div class="sm:flex-1">
        <label for="search" class="sr-only">Search courses</label>

        <input
          type="text"
          id="search"
          placeholder={$_(`pages.courses.input_label`)}
          class="w-full h-10 rounded-md border-gray-200 bg-white p-3 text-gray-700 shadow-sm transition focus:border-white focus:outline-none focus:ring focus:ring-yellow-400"
          bind:value={search}
        />
      </div>

      <button
        type="submit"
        class="inline-block h-10 rounded-lg bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
      >
        <span class="text-sm font-medium">{$_(`pages.courses.search_button`)}</span>
      </button>
    </form>
  </div>

  {#if $courses.length === 0}
    <div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
      <p>{$_(`pages.courses.none_search`)}</p>
    </div>
  {:else}
    {#each $courses as course}
      <article
        class="mx-auto max-w-7xl overflow-hidden rounded-lg border border-gray-100 shadow-sm"
      >
        <div class="p-4 sm:p-6">
          <a href="/">
            <h3 class="text-lg font-medium text-gray-900">{course.name}</h3>
          </a>

          <p class="mt-2 text-sm leading-relaxed text-gray-500 line-clamp-3">
            {$_(`pages.courses.author`)}: {course.user.first_name} {course.user.last_name}
          </p>

          <a
            href="/"
            class="group mt-4 inline-flex items-center gap-1 text-sm font-medium text-blue-600"
          >
            {$_(`pages.courses.find`)}

            <span aria-hidden="true" class="block transition group-hover:translate-x-0.5">
              &rarr;
            </span>
          </a>
        </div>
      </article>
    {/each}
  {/if}
</div>
