<script lang="ts">
  import { onMount } from 'svelte';
  import { writable } from 'svelte/store';
  import { get } from '$utils/fetch';

  interface Course {
    name: string;
    user: {
      first_name: string;
    };
  }

  let courses = writable<Course[]>([]);
  let search = '';

  async function getCourses() {
    const response = await get(`/v1/courses?search=${search}`);
    const data = await response.json();
    courses.set(data as Course[]);
  }

  onMount(getCourses);
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">Courses:</h1>
  </div>
  <div class="mx-auto mt-8 max-w-xl">
    <form on:submit|preventDefault={getCourses} class="sm:flex sm:gap-4">
      <div class="sm:flex-1">
        <label for="search" class="sr-only">Search courses</label>

        <input
          type="text"
          id="search"
          placeholder="Search courses"
          class="w-full rounded-md border-gray-200 bg-white p-3 text-gray-700 shadow-sm transition focus:border-white focus:outline-none focus:ring focus:ring-yellow-400"
          bind:value={search}
        />
      </div>

      <button
        type="submit"
        class="group mt-4 flex w-full items-center justify-center rounded-md bg-rose-600 px-5 py-3 text-white transition focus:outline-none focus:ring focus:ring-yellow-400 sm:mt-0 sm:w-auto"
      >
        <span class="text-sm font-medium"> Search </span>

        <svg
          class="ml-3 h-5 w-5"
          xmlns="http://www.w3.org/2000/svg"
          fill="none"
          viewBox="0 0 24 24"
          stroke="currentColor"
        >
          <path
            stroke-linecap="round"
            stroke-linejoin="round"
            stroke-width="2"
            d="M17 8l4 4m0 0l-4 4m4-4H3"
          />
        </svg>
      </button>
    </form>
  </div>

  {#if $courses.length === 0}
    <div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8"><p>Courses found: 0</p></div>
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
            Author: {course.user.first_name}
          </p>

          <a
            href="/"
            class="group mt-4 inline-flex items-center gap-1 text-sm font-medium text-blue-600"
          >
            Find out more

            <span aria-hidden="true" class="block transition group-hover:translate-x-0.5">
              &rarr;
            </span>
          </a>
        </div>
      </article>
    {/each}
  {/if}
</div>
