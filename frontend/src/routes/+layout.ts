import '$lib/i18n'; // Import to initialize. Important :)
import { locale, waitLocale } from 'svelte-i18n';
import type { LayoutLoad } from './$types';
import { localeStoragevalue } from '$lib/i18n/index.js';

export const load: LayoutLoad = async () => {
  locale.set(localeStoragevalue());
  await waitLocale();
};
