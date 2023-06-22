import type { Actions } from './$types';
import { fail } from '@sveltejs/kit';

export const actions: Actions = {
  default: async ({ request, cookies, fetch }) => {
    const form = await request.formData();
    const name = form.get('name');

    type Errors = string[] | string;

    type ResponseData = {
      error?: Errors;
    };

    const result = await fetch('http://backend:3000/api/v1/courses', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${cookies.get('token')}`
      },
      body: JSON.stringify({ name })
    });
  

    const response: ResponseData = await result.json();
    if (result.status === 422) {
      let errors = response.error;
      return fail(422, { errors });
    } else {
      return { success: true }
    }
  }
} satisfies Actions;


