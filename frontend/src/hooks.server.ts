// hooks.server.ts
import { redirect, type Handle } from '@sveltejs/kit';
import { locale } from 'svelte-i18n';

export const handle = (async ({ event, resolve }) => {
  const lang = event.request.headers.get('accept-language')?.split(',')[0];
  if (lang) {
    locale.set(lang);
  }

  const unProtectedRoutes = ['/', '/sign-in', '/sign-up'];

  const jwtToken = event.cookies.get('token');
  if (!jwtToken && !unProtectedRoutes.includes(event.url.pathname)) {
    throw redirect(303, '/');
  }

  event.locals.user = {
    isAuthenticated: true,
    email: 'work.pupko@gmail.com',
    id: '1',
  }

  const query = event.url.searchParams.get('signout');

  if (Boolean(query) == true) {
    event.cookies.delete('token');
    event.cookies.delete('refreshToken');
  }

  return resolve(event);
}) satisfies Handle;
