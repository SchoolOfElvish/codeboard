import '$lib/i18n'; // Import to initialize. Important :)
import { browser } from '$app/environment';
import { locale, waitLocale } from 'svelte-i18n';
import type { LayoutLoad } from './$types';
import { defineLocale } from '$lib/i18n/index.js';

export const load: LayoutLoad = async () => {
  if (browser) {
    locale.set(defineLocale());
  }
  await waitLocale();
};
