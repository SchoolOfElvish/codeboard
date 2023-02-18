import wretch from 'wretch'
import user from '$stores/user'
import { get as storeGet } from 'svelte/store'

export type FetchParamsType = Record<string, string>
export type FetchDataType = Record<string, any>
export type FetchResponseType = object

export type FetchMethod = 'get' | 'post' | 'put' | 'delete'

import { PUBLIC_BACKEND_URL } from '$env/static/public';

const api = wretch(`${PUBLIC_BACKEND_URL}/api`);

interface ResponseData {
  token: string,
  refresh_token: string
}

const fetch = async (url: string, method: FetchMethod, data: Record<string, unknown>) => {
  let request = api.url(url).auth(`Bearer ${storeGet(user).token}`);

  let requestWithMethod;
  switch (method) {
    case 'get':
      requestWithMethod = request.get();
      break;
    case 'post':
      requestWithMethod = request.post(data);
      break;
    case 'put':
      requestWithMethod = request.put(data);
      break;
    case 'delete':
      requestWithMethod = request.delete();
      break;
    default:
      throw new Error(`Unsupported HTTP method: ${method}`);
  }

  return requestWithMethod.unauthorized((error, req) => refreshTokens(error, req, data))
}

const getToken = async () => {
  const response = await api.url("/v1/refresh").post({
    token: storeGet(user).token,
    refreshToken: storeGet(user).refreshToken
  }).json<ResponseData>();

  user.set({ token: response.token, refreshToken: response.refresh_token });
}

const refreshTokens = async (_error: Error, req: any, data: Record<string, unknown>) => {
  await getToken()
  return req
    .auth(`Bearer ${storeGet(user).token}`)
    .post(data)
    .unauthorized((err: Error) => { throw err; }).json();
}

export default fetch;

export const post = async (url: string, data: Record<string, unknown>) => {
  return fetch(url, 'post', data)
}

export const get = async (url: string) => {
  return fetch(url, 'get', {})
}

export const put = async (url: string, data: Record<string, unknown>) => {
  return fetch(url, 'put', data)
}

export const del = async (url: string) => {
  return fetch(url, 'delete', {})
}
