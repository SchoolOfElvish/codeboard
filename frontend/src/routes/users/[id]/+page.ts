import { get } from '$utils/fetch';

export const ssr = false;

type ResponseData = {
  first_name: string;
  last_name: string;
  role: string;
  created_at: Date;
};

export const load = async ({ params }) => {
  const response = await (await get(`/v1/users/${params.id}`)).json<ResponseData>();
  return { response };
};
