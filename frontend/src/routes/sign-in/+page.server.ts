import type { Actions, PageServerLoad } from './$types';
import wretch from 'wretch';
import { dev } from '$app/environment';
import { redirect } from '@sveltejs/kit';

// export const load = (async ({ cookies }) => {
//     const user = await db.getUserFromSession(cookies.get('sessionid'));
//     return { user };
// }) satisfies PageServerLoad;

type ResponseData = {
  token: string;
  refresh_token: string;
};

const setCookie = (cookies: any, name: string, value: string, remember: boolean) => {
  const defaultOptions = {
    path: '/',
    httpOnly: true,
    sameSite: 'strict',
    secure: !dev,
  }

  const temporaryCookieOptions = { maxAge: 60 * 60 * 24 * 7  }

  cookies.set(name, value, { ...defaultOptions, ...(remember && temporaryCookieOptions) });
};

export const actions = {
  default: async ({request, cookies, fetch}) => {
    const form = await request.formData();
    const email = form.get('email');
    const password = form.get('password');
    const remember = Boolean(form.get('remember-me')) == true;

    const response = await fetch('http://backend:3000/api/v1/sign-in', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password }),
    })

    const body = await response.json() as ResponseData;

    setCookie(cookies, 'token', body.token, remember);
    setCookie(cookies, 'refreshToken', body.refresh_token, remember);

    throw redirect(302, '/');
  },
} satisfies Actions;
