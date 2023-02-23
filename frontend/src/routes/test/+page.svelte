<script lang="ts">
  import wretch from 'wretch';
  const api = wretch('http://localhost:3000/api');
  import user from '$stores/user';

  interface ResponseData {
    token: string;
    refresh_token: string;
  }

  const fetch = async (url: string, data: Record<string, string>) => {
    await api
      .url(url)
      .auth(`Bearer ${$user.token}`)
      .post(data)
      .unauthorized((error, req) => refreshTokens(error, req, data))
      .json();
  };

  const getToken = async () => {
    const response = await api
      .url('/v1/refresh')
      .post({
        token: $user.token,
        refreshToken: $user.refreshToken
      })
      .json<ResponseData>();

    user.set({ token: response.token, refreshToken: response.refresh_token });
  };

  const refreshTokens = async (_error: Error, req: unknown, data: Record<string, string>) => {
    await getToken();
    return req
      .auth(`Bearer ${$user.token}`)
      .post(data)
      .unauthorized((err: Error) => {
        throw err;
      })
      .json();
  };

  const makeRequest = () => {
    fetch('/v1/hello', {});
  };
</script>

<button on:click={makeRequest}>Click</button>
