import { redirect } from '@sveltejs/kit';

import type { PageServerLoad } from './$types';
import Wretch from 'wretch';
import user from '$stores/user';


type ResponseData = {
  token: string;
  refresh_token: string;
};


export const load: PageServerLoad = (async ({ params, fetch, url }) => {
  let token = url.searchParams.get('confirmation_token');

  const api = Wretch('http://backend:3000/');
  const response = await api.url('api/v1/confirm_email').post({ confirmation_token: token }).json<ResponseData>();
  
  console.log(response);


if (response) {
    if (response.token) {
      user.set({ token: response.token, refreshToken: response.refresh_token });
    }
  }

  throw redirect(302, "http://localhost:3001/users/me");
}) satisfies PageServerLoad;


