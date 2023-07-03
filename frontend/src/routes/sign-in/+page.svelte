<script lang="ts">
  import { _ } from 'svelte-i18n';

  let email = '';
  let password = '';

  let errors: Error = {};

  type Error = {
    [key: string]: string;
  };

  type ResponseData = {
    token: string;
    refresh_token: string;
  };

  const logIn = async () => {
    const result = await post('/v1/sign-in', { email, password });

    const response = await result
      .error(403, async (error) => {
        errors = JSON.parse(error.message).error;
        error;
      })
      .json<ResponseData>();
    console.log(response);

    if (response) {
      if (response.token) {
        user.set({ token: response.token, refreshToken: response.refresh_token });
        // window.location.href = to.root();
      }
    }
  };
</script>

<div class="flex min-h-full flex-col py-20 sm:px-6 lg:px-8">
  <div class="sm:mx-auto sm:w-full sm:max-w-md">
    <img
      class="mx-auto h-12 w-auto"
      src="https://tailwindui.com/img/logos/mark.svg?color=indigo&shade=600"
      alt="Your Company"
    />
    <h2 class="mt-6 text-center text-3xl font-bold tracking-tight text-gray-900">
      {$_('pages.sign_in.title')}
    </h2>
  </div>

  <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-md">
    {#if Object.keys(errors).length > 0}
      <div role="alert" class="rounded border-l-4 border-red-500 bg-red-100 p-3 mb-2">
        <strong class="block font-medium text-red-700"> Something went wrong </strong>

        <p class="mt-2 text-sm text-red-700">
          {$_(`pages.sign_in.errors.${errors}`)}
        </p>
      </div>
    {/if}

    <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
      <form method="POST" class="space-y-6">
        <div>
          <label for="email" class="block text-sm font-medium text-gray-700"
            >{$_('pages.sign_in.email')}</label
          >
          <div class="mt-1">
            <input
              id="email"
              name="email"
              type="text"
              autocomplete="email"
              required
              bind:value={email}
              class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
            />
          </div>
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-gray-700"
            >{$_('pages.sign_in.password')}</label
          >
          <div class="mt-1">
            <input
              id="password"
              name="password"
              type="password"
              autocomplete="current-password"
              required
              bind:value={password}
              class="block w-full appearance-none rounded-md border border-gray-300 px-3 py-2 placeholder-gray-400 shadow-sm focus:border-indigo-500 focus:outline-none focus:ring-indigo-500 sm:text-sm"
            />
          </div>
        </div>

        <div class="flex items-center justify-between">
          <div class="flex items-center">
            <input
              id="remember-me"
              name="remember-me"
              type="checkbox"
              class="h-4 w-4 rounded border-gray-300 text-indigo-600 focus:ring-indigo-500"
            />
            <label for="remember-me" class="ml-2 block text-sm text-gray-900"
              >{$_('pages.sign_in.remember')}</label
            >
          </div>

          <div class="text-sm">
            <a href="/" class="font-medium text-indigo-600 hover:text-indigo-500"
              >{$_('pages.sign_in.forgot')}</a
            >
          </div>
        </div>

        <div>
          <button
            type="submit"
            class="flex w-full justify-center rounded-md border border-transparent bg-indigo-600 py-2 px-4 text-sm font-medium text-white shadow-sm hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-indigo-500 focus:ring-offset-2"
            >{$_('pages.sign_in.sign_in_button')}</button
          >
        </div>
      </form>
    </div>
  </div>
</div>
