import '$lib/i18n'; // Import to initialize. Important :)
import { browser } from '$app/environment';
import { locale, waitLocale } from 'svelte-i18n';
import type { LayoutServerLoad } from './$types';
import { defineLocale } from '$lib/i18n/index.js';

export const load: LayoutServerLoad = async ({locals}) => {

  console.log("Server load");
  return {
    user: locals.user
  }
};
