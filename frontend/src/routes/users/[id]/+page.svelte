<script lang="ts">
  import { to } from '$lib/routes';
  import type { PageData } from './$types';
  export let data: PageData;
  import { _ } from 'svelte-i18n';

  let {
    first_name: firstName,
    last_name: lastName,
    role,
    created_at,
    about_info: aboutInfo
  } = data.response;
</script>

<!-- https://tailwindui.com/components/application-ui/page-examples/detail-screens#component-80034b9052ca551c25f7d731b7b3c6dd -->
<div class="min-h-full">
  <main class="py-3">
    <!-- Page header -->
    <div
      class="mx-auto max-w-3xl px-4 sm:px-6 md:flex md:items-center md:justify-between md:space-x-5 lg:max-w-7xl lg:px-8"
    >
      <div class="flex items-center space-x-5">
        <div class="flex-shrink-0">
          <div class="relative">
            <img
              class="h-16 w-16 rounded-full"
              src="https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=1024&h=1024&q=80"
              alt=""
            />
            <span class="absolute inset-0 rounded-full shadow-inner" aria-hidden="true" />
          </div>
        </div>
        <div>
          <h1 class="text-2xl font-bold text-gray-900">{firstName} {lastName}</h1>
          <p class="text-sm font-medium text-gray-500">
            <b>{role}</b>
            <time datetime="2020-08-25">since {created_at}</time>
          </p>
        </div>
      </div>
      <div
        class="justify-stretch mt-6 flex flex-col-reverse space-y-4 space-y-reverse sm:flex-row-reverse sm:justify-end sm:space-y-0 sm:space-x-3 sm:space-x-reverse md:mt-0 md:flex-row md:space-x-3"
      >
        <a
          type="button"
          class="inline-flex items-center justify-center rounded-md bg-white px-3 py-2 text-sm font-semibold text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 hover:bg-gray-50"
          href={to.users.me()}>Edit profile</a
        >
      </div>
    </div>

    <div
      class="mx-auto mt-8 grid max-w-3xl grid-cols-1 gap-6 sm:px-6 lg:max-w-7xl lg:grid-flow-col-dense lg:grid-cols-3"
    >
      <div class="space-y-6 lg:col-span-2 lg:col-start-1">
        <!-- Description list-->
        <section aria-labelledby="applicant-information-title">
          <div class="bg-white shadow sm:rounded-lg">
            <div class="px-4 py-5 sm:px-6">
              <h2
                id="applicant-information-title"
                class="text-lg font-medium leading-6 text-gray-900"
              >
                Applicant Information
              </h2>
              <p class="mt-1 max-w-2xl text-sm text-gray-500">Personal details and application.</p>
            </div>
            <div class="border-t border-gray-200 px-4 py-5 sm:px-6">
              <dl class="grid grid-cols-1 gap-x-4 gap-y-8 sm:grid-cols-2">
                <div class="sm:col-span-1">
                  <dt class="text-sm font-medium text-gray-500">Application for</dt>
                  <dd class="mt-1 text-sm text-gray-900">Backend Developer</dd>
                </div>
                <div class="sm:col-span-1">
                  <dt class="text-sm font-medium text-gray-500">Email address</dt>
                  <dd class="mt-1 text-sm text-gray-900">ricardocooper@example.com</dd>
                </div>
                <div class="sm:col-span-1">
                  <dt class="text-sm font-medium text-gray-500">Salary expectation</dt>
                  <dd class="mt-1 text-sm text-gray-900">$120,000</dd>
                </div>
                <div class="sm:col-span-1">
                  <dt class="text-sm font-medium text-gray-500">Phone</dt>
                  <dd class="mt-1 text-sm text-gray-900">+1 555-555-5555</dd>
                </div>
                {#if aboutInfo}
                  <div class="sm:col-span-2">
                    <dt class="text-sm font-medium text-gray-500">
                      {$_(`pages.users.me.about_me`)}
                    </dt>
                    <dd class="mt-1 text-sm text-gray-900">
                      {aboutInfo}
                    </dd>
                  </div>
                {/if}
              </dl>
            </div>
            <div>
              <a
                href={to.root()}
                class="block bg-gray-50 px-4 py-4 text-center text-sm font-medium text-gray-500 hover:text-gray-700 sm:rounded-b-lg"
                >Read full application</a
              >
            </div>
          </div>
        </section>

        <!-- Comments-->
        <section aria-labelledby="notes-title">
          <div class="bg-white shadow sm:overflow-hidden sm:rounded-lg">
            <div class="divide-y divide-gray-200">
              <div class="px-4 py-5 sm:px-6">
                <h2 id="notes-title" class="text-lg font-medium text-gray-900">Notes</h2>
              </div>
              <div class="px-4 py-6 sm:px-6">
                <!-- svelte-ignore a11y-no-redundant-roles -->
                <ul role="list" class="space-y-8">
                  <li>
                    <div class="flex space-x-3">
                      <div class="flex-shrink-0">
                        <img
                          class="h-10 w-10 rounded-full"
                          src="https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                          alt=""
                        />
                      </div>
                      <div>
                        <div class="text-sm">
                          <a href="to.root()" class="font-medium text-gray-900">Leslie Alexander</a>
                        </div>
                        <div class="mt-1 text-sm text-gray-700">
                          <p>
                            Ducimus quas delectus ad maxime totam doloribus reiciendis ex. Tempore
                            dolorem maiores. Similique voluptatibus tempore non ut.
                          </p>
                        </div>
                        <div class="mt-2 space-x-2 text-sm">
                          <span class="font-medium text-gray-500">4d ago</span>
                          <span class="font-medium text-gray-500">&middot;</span>
                          <!-- <button type="button" class="font-medium text-gray-900">Reply</button> -->
                        </div>
                      </div>
                    </div>
                  </li>

                  <li>
                    <div class="flex space-x-3">
                      <div class="flex-shrink-0">
                        <img
                          class="h-10 w-10 rounded-full"
                          src="https://images.unsplash.com/photo-1519244703995-f4e0f30006d5?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                          alt=""
                        />
                      </div>
                      <div>
                        <div class="text-sm">
                          <a href="to.root()" class="font-medium text-gray-900">Michael Foster</a>
                        </div>
                        <div class="mt-1 text-sm text-gray-700">
                          <p>
                            Et ut autem. Voluptatem eum dolores sint necessitatibus quos. Quis eum
                            qui dolorem accusantium voluptas voluptatem ipsum. Quo facere iusto quia
                            accusamus veniam id explicabo et aut.
                          </p>
                        </div>
                        <div class="mt-2 space-x-2 text-sm">
                          <span class="font-medium text-gray-500">4d ago</span>
                          <span class="font-medium text-gray-500">&middot;</span>
                          <!-- <button type="button" class="font-medium text-gray-900">Reply</button> -->
                        </div>
                      </div>
                    </div>
                  </li>

                  <li>
                    <div class="flex space-x-3">
                      <div class="flex-shrink-0">
                        <img
                          class="h-10 w-10 rounded-full"
                          src="https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=2&w=256&h=256&q=80"
                          alt=""
                        />
                      </div>
                      <div>
                        <div class="text-sm">
                          <a href="to.root()" class="font-medium text-gray-900">Dries Vincent</a>
                        </div>
                        <div class="mt-1 text-sm text-gray-700">
                          <p>
                            Expedita consequatur sit ea voluptas quo ipsam recusandae. Ab sint et
                            voluptatem repudiandae voluptatem et eveniet. Nihil quas consequatur
                            autem. Perferendis rerum et.
                          </p>
                        </div>
                        <div class="mt-2 space-x-2 text-sm">
                          <span class="font-medium text-gray-500">4d ago</span>
                          <span class="font-medium text-gray-500">&middot;</span>
                          <!-- <button type="button" class="font-medium text-gray-900">Reply</button> -->
                        </div>
                      </div>
                    </div>
                  </li>
                </ul>
              </div>
            </div>
            <div class="bg-gray-50 px-4 py-6 sm:px-6">
              <div class="flex space-x-3">
                <div class="flex-shrink-0">
                  <img
                    class="h-10 w-10 rounded-full"
                    src="https://images.unsplash.com/photo-1517365830460-955ce3ccd263?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=256&h=256&q=80"
                    alt=""
                  />
                </div>
                <div class="min-w-0 flex-1">
                  <form action="#">
                    <div>
                      <label for="comment" class="sr-only">About</label>
                      <textarea
                        id="comment"
                        name="comment"
                        rows="3"
                        class="block w-full rounded-md border-0 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-blue-600 sm:py-1.5 sm:text-sm sm:leading-6"
                        placeholder="Add a note"
                      />
                    </div>
                    <div class="mt-3 flex items-center justify-between">
                      <a
                        href="to.root()"
                        class="group inline-flex items-start space-x-2 text-sm text-gray-500 hover:text-gray-900"
                      >
                        <svg
                          class="h-5 w-5 flex-shrink-0 text-gray-400 group-hover:text-gray-500"
                          viewBox="0 0 20 20"
                          fill="currentColor"
                          aria-hidden="true"
                        >
                          <path
                            fill-rule="evenodd"
                            d="M18 10a8 8 0 11-16 0 8 8 0 0116 0zM8.94 6.94a.75.75 0 11-1.061-1.061 3 3 0 112.871 5.026v.345a.75.75 0 01-1.5 0v-.5c0-.72.57-1.172 1.081-1.287A1.5 1.5 0 108.94 6.94zM10 15a1 1 0 100-2 1 1 0 000 2z"
                            clip-rule="evenodd"
                          />
                        </svg>
                        <span>Some HTML is okay.</span>
                      </a>
                      <button
                        type="submit"
                        class="inline-flex items-center justify-center rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
                        >Comment</button
                      >
                    </div>
                  </form>
                </div>
              </div>
            </div>
          </div>
        </section>
      </div>

      <section aria-labelledby="timeline-title" class="lg:col-span-1 lg:col-start-3">
        <div class="bg-white px-4 py-5 shadow sm:rounded-lg sm:px-6">
          <h2 id="timeline-title" class="text-lg font-medium text-gray-900">Timeline</h2>

          <!-- Activity Feed -->
          <div class="mt-6 flow-root">
            <!-- svelte-ignore a11y-no-redundant-roles -->
            <ul role="list" class="-mb-8">
              <li>
                <div class="relative pb-8">
                  <span
                    class="absolute top-4 left-4 -ml-px h-full w-0.5 bg-gray-200"
                    aria-hidden="true"
                  />
                  <div class="relative flex space-x-3">
                    <div>
                      <span
                        class="h-8 w-8 rounded-full bg-gray-400 flex items-center justify-center ring-8 ring-white"
                      >
                        <svg
                          class="h-5 w-5 text-white"
                          viewBox="0 0 20 20"
                          fill="currentColor"
                          aria-hidden="true"
                        >
                          <path
                            d="M10 8a3 3 0 100-6 3 3 0 000 6zM3.465 14.493a1.23 1.23 0 00.41 1.412A9.957 9.957 0 0010 18c2.31 0 4.438-.784 6.131-2.1.43-.333.604-.903.408-1.41a7.002 7.002 0 00-13.074.003z"
                          />
                        </svg>
                      </span>
                    </div>
                    <div class="flex min-w-0 flex-1 justify-between space-x-4 pt-1.5">
                      <div>
                        <p class="text-sm text-gray-500">
                          Applied to <a href="to.root()" class="font-medium text-gray-900"
                            >Front End Developer</a
                          >
                        </p>
                      </div>
                      <div class="whitespace-nowrap text-right text-sm text-gray-500">
                        <time datetime="2020-09-20">Sep 20</time>
                      </div>
                    </div>
                  </div>
                </div>
              </li>

              <li>
                <div class="relative pb-8">
                  <span
                    class="absolute top-4 left-4 -ml-px h-full w-0.5 bg-gray-200"
                    aria-hidden="true"
                  />
                  <div class="relative flex space-x-3">
                    <div>
                      <span
                        class="h-8 w-8 rounded-full bg-blue-500 flex items-center justify-center ring-8 ring-white"
                      >
                        <svg
                          class="h-5 w-5 text-white"
                          viewBox="0 0 20 20"
                          fill="currentColor"
                          aria-hidden="true"
                        >
                          <path
                            d="M1 8.25a1.25 1.25 0 112.5 0v7.5a1.25 1.25 0 11-2.5 0v-7.5zM11 3V1.7c0-.268.14-.526.395-.607A2 2 0 0114 3c0 .995-.182 1.948-.514 2.826-.204.54.166 1.174.744 1.174h2.52c1.243 0 2.261 1.01 2.146 2.247a23.864 23.864 0 01-1.341 5.974C17.153 16.323 16.072 17 14.9 17h-3.192a3 3 0 01-1.341-.317l-2.734-1.366A3 3 0 006.292 15H5V8h.963c.685 0 1.258-.483 1.612-1.068a4.011 4.011 0 012.166-1.73c.432-.143.853-.386 1.011-.814.16-.432.248-.9.248-1.388z"
                          />
                        </svg>
                      </span>
                    </div>
                    <div class="flex min-w-0 flex-1 justify-between space-x-4 pt-1.5">
                      <div>
                        <p class="text-sm text-gray-500">
                          Advanced to phone screening by <a
                            href="to.root()"
                            class="font-medium text-gray-900">Bethany Blake</a
                          >
                        </p>
                      </div>
                      <div class="whitespace-nowrap text-right text-sm text-gray-500">
                        <time datetime="2020-09-22">Sep 22</time>
                      </div>
                    </div>
                  </div>
                </div>
              </li>

              <li>
                <div class="relative pb-8">
                  <span
                    class="absolute top-4 left-4 -ml-px h-full w-0.5 bg-gray-200"
                    aria-hidden="true"
                  />
                  <div class="relative flex space-x-3">
                    <div>
                      <span
                        class="h-8 w-8 rounded-full bg-green-500 flex items-center justify-center ring-8 ring-white"
                      >
                        <svg
                          class="h-5 w-5 text-white"
                          viewBox="0 0 20 20"
                          fill="currentColor"
                          aria-hidden="true"
                        >
                          <path
                            fill-rule="evenodd"
                            d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                            clip-rule="evenodd"
                          />
                        </svg>
                      </span>
                    </div>
                    <div class="flex min-w-0 flex-1 justify-between space-x-4 pt-1.5">
                      <div>
                        <p class="text-sm text-gray-500">
                          Completed phone screening with <a
                            href="to.root()"
                            class="font-medium text-gray-900">Martha Gardner</a
                          >
                        </p>
                      </div>
                      <div class="whitespace-nowrap text-right text-sm text-gray-500">
                        <time datetime="2020-09-28">Sep 28</time>
                      </div>
                    </div>
                  </div>
                </div>
              </li>

              <li>
                <div class="relative pb-8">
                  <span
                    class="absolute top-4 left-4 -ml-px h-full w-0.5 bg-gray-200"
                    aria-hidden="true"
                  />
                  <div class="relative flex space-x-3">
                    <div>
                      <span
                        class="h-8 w-8 rounded-full bg-blue-500 flex items-center justify-center ring-8 ring-white"
                      >
                        <svg
                          class="h-5 w-5 text-white"
                          viewBox="0 0 20 20"
                          fill="currentColor"
                          aria-hidden="true"
                        >
                          <path
                            d="M1 8.25a1.25 1.25 0 112.5 0v7.5a1.25 1.25 0 11-2.5 0v-7.5zM11 3V1.7c0-.268.14-.526.395-.607A2 2 0 0114 3c0 .995-.182 1.948-.514 2.826-.204.54.166 1.174.744 1.174h2.52c1.243 0 2.261 1.01 2.146 2.247a23.864 23.864 0 01-1.341 5.974C17.153 16.323 16.072 17 14.9 17h-3.192a3 3 0 01-1.341-.317l-2.734-1.366A3 3 0 006.292 15H5V8h.963c.685 0 1.258-.483 1.612-1.068a4.011 4.011 0 012.166-1.73c.432-.143.853-.386 1.011-.814.16-.432.248-.9.248-1.388z"
                          />
                        </svg>
                      </span>
                    </div>
                    <div class="flex min-w-0 flex-1 justify-between space-x-4 pt-1.5">
                      <div>
                        <p class="text-sm text-gray-500">
                          Advanced to interview by <a
                            href="to.root()"
                            class="font-medium text-gray-900">Bethany Blake</a
                          >
                        </p>
                      </div>
                      <div class="whitespace-nowrap text-right text-sm text-gray-500">
                        <time datetime="2020-09-30">Sep 30</time>
                      </div>
                    </div>
                  </div>
                </div>
              </li>

              <li>
                <div class="relative pb-8">
                  <div class="relative flex space-x-3">
                    <div>
                      <span
                        class="h-8 w-8 rounded-full bg-green-500 flex items-center justify-center ring-8 ring-white"
                      >
                        <svg
                          class="h-5 w-5 text-white"
                          viewBox="0 0 20 20"
                          fill="currentColor"
                          aria-hidden="true"
                        >
                          <path
                            fill-rule="evenodd"
                            d="M16.704 4.153a.75.75 0 01.143 1.052l-8 10.5a.75.75 0 01-1.127.075l-4.5-4.5a.75.75 0 011.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 011.05-.143z"
                            clip-rule="evenodd"
                          />
                        </svg>
                      </span>
                    </div>
                    <div class="flex min-w-0 flex-1 justify-between space-x-4 pt-1.5">
                      <div>
                        <p class="text-sm text-gray-500">
                          Completed interview with <a
                            href="to.root()"
                            class="font-medium text-gray-900">Katherine Snyder</a
                          >
                        </p>
                      </div>
                      <div class="whitespace-nowrap text-right text-sm text-gray-500">
                        <time datetime="2020-10-04">Oct 4</time>
                      </div>
                    </div>
                  </div>
                </div>
              </li>
            </ul>
          </div>
          <div class="justify-stretch mt-6 flex flex-col">
            <button
              type="button"
              class="inline-flex items-center justify-center rounded-md bg-blue-600 px-3 py-2 text-sm font-semibold text-white shadow-sm hover:bg-blue-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-blue-600"
              >Advance to offer</button
            >
          </div>
        </div>
      </section>
    </div>
  </main>
</div>
