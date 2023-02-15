import wretch from 'wretch'
import user from '$stores/user'

const api = wretch('http://localhost:3000/api');

interface ResponseData {
  token: string,
  refresh_token: string
}

const fetch = async <T>(url: string, method: string, responseType: string, data: Record<string, unknown>): Promise<T> => {
  let request = api.url(url).auth(`Bearer ${user.token}`);

  switch (method) {
    case 'get':
      request = request.get();
      break;
    case 'post':
      request = request.post(data);
      break;
    case 'put':
      request = request.put(data);
      break;
    case 'delete':
      request = request.delete(data);
      break;
    default:
      throw new Error(`Unsupported HTTP method: ${method}`);
  }

  if (responseType === 'json') {
    request = request.json();
  } else if (responseType === 'text') {
    request = request.text();
  } else if (responseType === 'blob') {
    request = request.blob();
  }

  return request
    .unauthorized((error, req) => refreshTokens(error, req, data))
    .toPromise();
}

const getToken = async () => {
  const response = await api.url("/v1/refresh").post({
    token: user.token,
    refreshToken: user.refreshToken
  }).json<ResponseData>();

  user.set({ token: response.token, refreshToken: response.refresh_token });
}

const refreshTokens = async (_error: Error, req: any, data: Record<string, unknown>) => {
  await getToken()
  return req
    .auth(`Bearer ${user.token}`)
    .post(data)
    .unauthorized((err: Error) => { throw err; }).json();
}

export const fetch;
