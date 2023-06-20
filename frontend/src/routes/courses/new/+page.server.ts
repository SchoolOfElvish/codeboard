import type { Actions } from './$types';
import { redirect } from '@sveltejs/kit';

export const actions: Actions = {
  default: async ({ request, cookies, fetch }) => {
    const form = await request.formData();
    const name = form.get('name');

    const result = await fetch('http://backend:3000/api/v1/courses', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${cookies.get('token')}`
      },
      body: JSON.stringify({ name })
    });

    console.log(result.headers);
  }
} satisfies Actions;
