import { get } from '$utils/fetch';
import { error } from '@sveltejs/kit';
import type { RouteParams } from './$types';

export const ssr = false;
let errors: string;

type ResponseData = {
  first_name: string;
  last_name: string;
  role: string;
  created_at: Date;
};

export const load = async ({ params }: { params: RouteParams }) => {
  const response = await (await get(`/v1/users/${params.id}`)).json<ResponseData>();
  return { response, errors };
};
