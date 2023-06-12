import type { Actions } from './$types';
import { redirect } from '@sveltejs/kit';
import { setCookie } from '$utils/cookies';

type ResponseData = {
  token: string;
  refresh_token: string;
};

export const actions = {
  default: async ({ request, cookies, fetch }) => {
    const form = await request.formData();
    const email = form.get('email');
    const password = form.get('password');
    const remember = Boolean(form.get('remember-me')) == true;

    const response = await fetch('http://backend:3000/api/v1/sign-in', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ email, password })
    });

    const body = (await response.json()) as ResponseData;

    setCookie(cookies, 'token', body.token, remember);
    setCookie(cookies, 'refreshToken', body.refresh_token, remember);

    throw redirect(302, '/');
  }
} satisfies Actions;
