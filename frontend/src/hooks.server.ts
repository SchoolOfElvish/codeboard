// hooks.server.ts
import { redirect, type Handle } from '@sveltejs/kit';
import { locale } from 'svelte-i18n';
import { verifyAndDecodeToken } from '$utils/jwt';

export const handle = (async ({ event, resolve }) => {
  const lang = event.request.headers.get('accept-language')?.split(',')[0];
  if (lang) {
    locale.set(lang);
  }

  const unProtectedRoutes = ['/', '/sign-in', '/sign-up', '/sign-out'];

  const jwtToken = event.cookies.get('token');
  // if (!jwtToken && !unProtectedRoutes.includes(event.url.pathname)) {
  //   throw redirect(303, '/');
  // }

  console.log('pathname', event.url.pathname);
  if (!unProtectedRoutes.includes(event.url.pathname)) {
    if (!jwtToken) {
      throw redirect(303, '/');
    }
  }

  let email = null;
  let id = null;
  let isAuthenticated = false;

  if (jwtToken) {
    const decodedToken = verifyAndDecodeToken(jwtToken);
    if (decodedToken) {
      isAuthenticated = true;
      email = decodedToken.email;
      id = decodedToken.id;
    }
  }

  if (event.url.pathname == '/sign-out') {
    event.cookies.delete('token');
    event.cookies.delete('refreshToken');
    throw redirect(302, '/sign-in');
  }

  event.locals.user = {
    isAuthenticated: isAuthenticated,
    email: email,
    id: id,
  }

  console.log(event.locals.user);

  return resolve(event);
}) satisfies Handle;
