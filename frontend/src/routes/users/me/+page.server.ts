import type { PageServerLoad } from './$types';

type ResponseData = {
  first_name: string;
  last_name: string;
  email: string;
  birthdate: string;
  about_info: string;
};

export const load = (async ({ cookies, fetch }) => {
  const result = await fetch('http://backend:3000/api/v1/users/me', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${cookies.get('token')}`
    }
  });

  const response = (await result.json()) as ResponseData;

  return { response };
}) satisfies PageServerLoad;
