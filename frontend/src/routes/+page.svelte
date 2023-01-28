<header aria-label="Site Header" class="bg-white">
  <div
    class="mx-auto flex h-16 max-w-screen-xl items-center gap-8 px-4 sm:px-6 lg:px-8"
  >
    
    <div class="flex flex-1 items-center justify-end md:justify-between">
      <nav aria-label="Site Nav" class="hidden md:block">
        <ul class="flex items-center gap-6 text-sm">
          <li>
            <a class="text-rose-500 transition hover:text-rose-500/75" href="/">
              Create group
            </a>
          </li>
        </ul>
      </nav>

      <div class="flex items-center gap-4">
        <div class="sm:flex sm:gap-4">
          <a
            class="block rounded-md bg-rose-600 px-5 py-2.5 text-sm font-medium text-white transition hover:bg-teal-700"
            href="/"
          >
            Login
          </a>

          <a
            class="hidden rounded-md bg-rose-100 px-5 py-2.5 text-sm font-medium text-rose-600 transition hover:text-rose-600/75 sm:block"
            href="/"
          >
            Register
          </a>
        </div>

        <button
          class="block rounded bg-rose-100 p-2.5 text-rose-600 transition hover:text-rose-600/75 md:hidden"
        >
          <span class="sr-only">Toggle menu</span>
          <svg
            xmlns="http://www.w3.org/2000/svg"
            class="h-5 w-5"
            fill="none"
            viewBox="0 0 24 24"
            stroke="currentColor"
            stroke-width="2"
          >
            <path
              stroke-linecap="round"
              stroke-linejoin="round"
              d="M4 6h16M4 12h16M4 18h16"
            />
          </svg>
        </button>
      </div>
    </div>
  </div>
</header>




<section class="bg-gray-50">
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
			<form action="/" class="sm:flex sm:gap-4">
				<div class="sm:flex-1">
					<label for="email" class="sr-only">Email</label>

					<input
						type="email"
						placeholder="Email address"
						class="w-full rounded-md border-gray-200 bg-white p-3 text-gray-700 shadow-sm transition focus:border-white focus:outline-none focus:ring focus:ring-yellow-400"
					/>
				</div>

				<button
					type="submit"
					class="group mt-4 flex w-full items-center justify-center rounded-md bg-rose-600 px-5 py-3 text-white transition focus:outline-none focus:ring focus:ring-yellow-400 sm:mt-0 sm:w-auto"
				>
					<span class="text-sm font-medium"> Sign Up </span>

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
	</div>
</section>
