import type { PageLoad } from './$types';
import { get } from '$utils/fetch';

type ResponseData = {
  firstName: string;
  lastName: string;
  email: string;
  birthdate: string;
};

export const load = (async () => {
  const response = await (await get('/v1/users/me')).json<ResponseData>();

  return { response };
}) satisfies PageLoad;
