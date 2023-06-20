import type { Actions } from './$types';
import { setCookie } from '$utils/cookies';
import { redirect } from '@sveltejs/kit';
import { fail } from '@sveltejs/kit';

export const actions: Actions = {
  default: async ({ request, cookies, fetch }) => {
    const form = await request.formData();
    const firstName = form.get('first_name');
    const lastName = form.get('last_name');
    const email = form.get('email');
    const password = form.get('password');
    const passwordConfirmation = form.get('password_confirmation');
    const role = form.get('role');
    const remember = false;

    type Errors = string[] | string;

    type ResponseData = {
      token: string;
      refresh_token: string;
      error?: Errors;
    };

    const result = await fetch('http://backend:3000/api/v1/sign-up', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ firstName, lastName, email, password, passwordConfirmation, role })
    });

    const response: ResponseData = await result.json();

    if (result.status === 422) {
      let errors = response.error;
      return fail(422, { errors });
    } else {
      if (response.token) {
        setCookie(cookies, 'token', response.token, remember);
        setCookie(cookies, 'refreshToken', response.refresh_token, remember);
        throw redirect(302, '/');
      }
    }
  }
} satisfies Actions;
