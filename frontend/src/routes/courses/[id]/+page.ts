import { get } from '$utils/fetch';
import type { Course } from '$components/course';
import type { Lesson } from '$components/lesson';
import type { RouteParams } from './$types';

export const ssr = false;
let errors: string;

export const load = async ({ params }: { params: RouteParams }) => {
  const response_course = await (await get(`/v1/courses/${params.id}`)).json<Course>();
  const response_lessons = await (await get(`/v1/courses/${params.id}/lessons`)).json<Lesson[]>();
  return { response_course, response_lessons, errors };
};
