import { get } from '$utils/fetch';
import type { PageLoad } from './$types';

export const ssr = false;

type ResponseData = {
  first_name: string;
  last_name: string;
  email: string;
  birthdate: string;
  about_info: string;
};

export const load = (async () => {
  const response = await (await get('/v1/users/me')).json<ResponseData>();

  return { response };
}) satisfies PageLoad;
