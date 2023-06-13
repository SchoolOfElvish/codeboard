import type { Actions } from './$types';
import { setCookie } from '$utils/cookies';
import { redirect } from '@sveltejs/kit';

type ResponseData = {
  token: string;
  refresh_token: string;
};

export const actions: Actions = {
  default: async ({ request, cookies, fetch}) => {
    const form = await request.formData();
    const firstName = form.get('first_name');
    const lastName = form.get('last_name');
    const email = form.get('email');
    const password = form.get('password');
    const passwordConfirmation = form.get('password_confirmation');
    const role = form.get('role');
    const remember = false
  
    
    const response = await fetch('http://backend:3000/api/v1/sign-up', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ firstName, lastName, email, password, passwordConfirmation, role })
    });

    const body = (await response.json()) as ResponseData;
    console.log(body)
    setCookie(cookies, 'token', body.token, remember);
    setCookie(cookies, 'refreshToken', body.refresh_token, remember);

    throw redirect(302, '/');
  }
}satisfies Actions;
