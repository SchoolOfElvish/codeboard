import '$lib/i18n'; // Import to initialize. Important :)
import { browser } from '$app/environment';
import { locale, waitLocale } from 'svelte-i18n';
import type { LayoutLoad } from './$types';
import { defineLocale } from '$lib/i18n/index.js';

export const load: LayoutLoad = async ({parent}) => {
  const { user } = await parent();
  if (browser) {
    locale.set(defineLocale());
  }

  const result = await parent();

  console.log('result', result);
  console.log("Client load");
  await waitLocale();
  return {
    user: user
  }
};
