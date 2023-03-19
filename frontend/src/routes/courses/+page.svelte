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

  async function getCourses() {
  const response = await get('/v1/courses');
  const data = await response.json();
  courses.set(data as Course[]);
}

  onMount(getCourses);
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">Courses:</h1>
  </div>

  {#each $courses as course}
    <article class="mx-auto max-w-7xl overflow-hidden rounded-lg border border-gray-100 shadow-sm">
      <div class="p-4 sm:p-6">
        <a href="/">
          <h3 class="text-lg font-medium text-gray-900">{course.name}</h3>
        </a>

        <p class="mt-2 text-sm leading-relaxed text-gray-500 line-clamp-3">
          {course.user.first_name}
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
</div>
