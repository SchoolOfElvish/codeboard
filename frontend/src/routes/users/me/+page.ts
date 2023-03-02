import { get } from '$utils/fetch';
import type { PageLoad  } from './$types';

type ResponseData = {
  first_name: string;
  last_name: string;
  email: string;
  birthdate: string;
};

export const load = (async () => {
  const response = await (await get('/v1/users/me')).json<ResponseData>();

  return { response };
}) satisfies PageLoad;
