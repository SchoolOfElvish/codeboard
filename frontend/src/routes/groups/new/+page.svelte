<script>
	let title = '';
	let email = '';
</script>

<div class="mx-auto max-w-screen-xl px-4 py-16 sm:px-6 lg:px-8">
	<div class="mx-auto max-w-lg text-center">
		<h1 class="text-2xl font-bold sm:text-3xl">Create group:</h1>
	</div>

	<form action="" class="mx-auto mt-8 mb-0 max-w-md space-y-4">
		<div>
			<label for="title" class="sr-only">title</label>
			<div class="relative ">
				<input
					bind:value={title}
					minlength="4"
					type="text"
					class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
					placeholder="Enter group title"
				/>
			</div>
		</div>

		<div>
			<label for="descriptoin" class="sr-only">email</label>
			<div class="relative">
				<input
					bind:value={email}
					type="email"
					maxlength="255"
					class="w-full rounded-lg border-gray-200 p-4 pr-12 text-sm shadow-sm invalid:border-red-500"
					placeholder="Input emails of users you want to invite"
				/>
			</div>
		</div>

		<div class="flex items-center justify-between">
			<button
				type="submit"
				class="ml-3 inline-block rounded-lg bg-rose-500 px-5 py-3 text-sm font-medium text-white"
			>
				Create Group
			</button>
		</div>
	</form>
</div>
