import { get } from '$utils/fetch';
import type { Course } from '$components/course';
import type { RouteParams } from './$types';

export const ssr = false;
let errors: string;

export const load = async ({ params }: { params: RouteParams }) => {
  const response = await (await get(`/v1/courses/${params.id}`)).json<Course>();
  return { response, errors };
};
