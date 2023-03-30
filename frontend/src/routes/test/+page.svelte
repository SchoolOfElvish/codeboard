<script lang="ts">
  import { put } from "$utils/fetch";


  let avatar: string | undefined;
  let fileinput: HTMLInputElement | undefined;
  $: console.log("Avatar" + avatar)
  $: console.log("File input" + fileinput)

  const onFileSelected = (e: Event) => {
    const target = e.target as HTMLInputElement;
    console.log("E");
    console.log(e);
    console.log("Target");
    console.log(target.files);
    if (target.files && target.files[0]) {
      const image = target.files[0];
      const reader = new FileReader();
      reader.readAsDataURL(image);
      reader.onload = (e: ProgressEvent<FileReader>) => {
        avatar = e.target?.result as string;
      };
    }
  };

  const submitUserData = async () => {
    const result = await put('/v1/test', {
      avatar: avatar
    });
  }

</script>

<div class="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
  <div class="col-span-full">
    <label for="photo" class="block text-sm font-medium leading-6 text-gray-900">Photo</label>
    <div class="mt-2 flex items-center gap-x-3">
      <svg
        class="h-12 w-12 text-gray-300"
        viewBox="0 0 24 24"
        fill="currentColor"
        aria-hidden="true"
      >
        <path
          fill-rule="evenodd"
          d="M18.685 19.097A9.723 9.723 0 0021.75 12c0-5.385-4.365-9.75-9.75-9.75S2.25 6.615 2.25 12a9.723 9.723 0 003.065 7.097A9.716 9.716 0 0012 21.75a9.716 9.716 0 006.685-2.653zm-12.54-1.285A7.486 7.486 0 0112 15a7.486 7.486 0 015.855 2.812A8.224 8.224 0 0112 20.25a8.224 8.224 0 01-5.855-2.438zM15.75 9a3.75 3.75 0 11-7.5 0 3.75 3.75 0 017.5 0z"
          clip-rule="evenodd"
        />
      </svg>
      <label
        for="file-upload"
        class="relative cursor-pointer rounded-md bg-white py-1.5 px-2.5 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50"
      >
        <input id="file-upload" name="file-upload" type="file" accept=".jpg, .jpeg, .png" class="sr-only" 
        on:change={(e)=>onFileSelected(e)} bind:this={fileinput} />
        Change</label
      >
    </div>
  </div>
  <div class="bg-gray-50 px-4 py-3 text-right sm:px-6">
    <button
      type="button"
      class="inline-flex justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
      on:click|preventDefault={submitUserData}
    >
      Save
    </button>
  </div>
</div>
