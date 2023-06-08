<script lang="ts">
  import { _ } from 'svelte-i18n';
  import type { PageData } from './$types';
  export let data: PageData
  import { onMount } from 'svelte';
  import { writable } from 'svelte/store';
  import { get } from '$utils/fetch';
  import type { Lesson } from '$components/lesson';

  
  let {
    name: name,
    user: user
  } = data.response;

  let lessons = writable<Lesson[]>([]);
          
  async function fetchLessons() {
    const data = await (await get(`v1/lessons`)).json<Lesson[]>();
    lessons.set(data);
  }

  onMount(fetchLessons);
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
  <div class="mx-auto max-w-lg text-center">
    <h1 class="text-2xl font-bold sm:text-3xl">{name}</h1>
    <p class="hidden text-gray-500 sm:mt-4 sm:block">{user.first_name} {user.last_name}</p>
  </div>
</div>



<article class="mx-auto max-w-7xl overflow-hidden rounded-lg border border-gray-100 shadow-sm">
  <div class="p-4 sm:p-6">
    <a href="/">
      <h3 class="text-lg font-medium text-gray-900">Lesson 1</h3>
    </a>

    <p class="mt-2 text-sm leading-relaxed text-gray-500 line-clamp-3">
      Lorem ipsum dolor sit amet, consectetur adipisicing elit. Recusandae dolores, possimus
      pariatur animi temporibus nesciunt praesentium dolore sed nulla ipsum eveniet corporis quidem,
      mollitia itaque minus soluta, voluptates neque explicabo tempora nisi culpa eius atque
      dignissimos. Molestias explicabo corporis voluptatem?
    </p>

    <a href="/" class="group mt-4 inline-flex items-center gap-1 text-sm font-medium text-blue-600">
      Find out more

      <span aria-hidden="true" class="block transition group-hover:translate-x-0.5"> &rarr; </span>
    </a>
  </div>
</article>
  