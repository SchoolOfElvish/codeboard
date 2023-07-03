import '$lib/i18n'; // Import to initialize. Important :)
import type { LayoutServerLoad } from './$types';

export const load: LayoutServerLoad = async ({ locals }) => {
  console.log('Server load');
  return {
    user: locals.user
  };
};
