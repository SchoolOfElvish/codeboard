import { get } from '$utils/fetch';
import type { PageServerLoad } from './$types';

type ResponseData = {
  first_name: string;
  last_name: string;
  email: string;
  birthdate: string;
  about_info: string;
};

export const load = (async ({parent, cookies, fetch}) => {
  // const response = await (await get('/v1/users/me')).json<ResponseData>();

  const result = await fetch('http://backend:3000/api/v1/users/me', {
    method: 'GET',
    headers: {
      'Content-Type': 'application/json',
      'Authorization': `Bearer ${cookies.get('token')}`
    },
    // headers: { 'Content-Type': 'application/json' },
  })

  const response = await result.json() as ResponseData;

  return { response };
}) satisfies PageServerLoad;
