<script lang="ts">
  import { _ } from 'svelte-i18n';
  import { goto } from '$app/navigation';

  interface Course {
    name: string;
    user: {
      first_name: string;
    };
  }
  let searchQuery = '';
  
  function submitForm() {
    if (searchQuery) {
      const query = encodeURIComponent(searchQuery.trim());
      goto(`/courses?search=${query}`);
    }
  }

</script>

<section>
  <div class="p-8 md:p-12 lg:px-16 lg:py-24">
    <div class="mx-auto max-w-lg text-center">
      <h2 class="text-2xl font-bold text-gray-900 md:text-3xl">
        Lorem, ipsum dolor sit amet consectetur adipisicing elit
      </h2>

      <p class="hidden text-gray-500 sm:mt-4 sm:block">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quae dolor officia blanditiis
        repellat in, vero, aperiam porro ipsum laboriosam consequuntur exercitationem incidunt
        tempora latest dva
      </p>
    </div>

    <div class="mx-auto mt-8 max-w-xl">
      <form action="/" class="sm:flex sm:gap-4" on:submit|preventDefault={submitForm}>
        <div class="sm:flex-1">
          <label for="email" class="sr-only">Email</label>

          <input
            type="text"
            placeholder={$_(`pages.root.input_label`)}
            class="w-full h-10 rounded-md border-gray-200 bg-white p-3 text-gray-700 shadow-sm transition focus:border-white focus:outline-none focus:ring focus:ring-yellow-400"
            bind:value={searchQuery}
          />
        </div>

        <button
          type="submit"
          class="inline-block h-10 rounded-md bg-indigo-600 px-4 py-2 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
        >
          <span class="text-sm font-medium">{$_(`pages.root.search_button`)}</span>
        </button>
      </form>
    </div>
  </div>
</section>
