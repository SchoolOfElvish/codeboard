import { get, writable } from 'svelte/store'
import { PUBLIC_API_URL } from '$env/static/public';

export type FetchParamsType = Record<string, string>
export type FetchDataType = Record<string, any>
export type FetchResponseType = object

export type FetchMethod = 'get' | 'post' | 'put' | 'delete'

class SerializationError extends Error {
  constructor(message: string) {
    super(`Serialization error: ${message}`)
  }
}

export type FetchOptions<
  Data extends FetchDataType,
  Params extends FetchParamsType
> = Omit<RequestInit, 'method' | 'body'> & {
  body?: Data
  params?: Params
}

type ResponseData<Data> = Data & {
  error?: string
}

async function fetch<
  Response extends FetchResponseType,
  Data extends FetchDataType,
  Params extends FetchParamsType
>(
  method: FetchMethod,
  path: string,
  options?: FetchOptions<Data, Params>
): Promise<ResponseData<Response> | null> {
  const { params, body, headers, ...fetchOptions } = options || {}
  const filteredParams: Params | undefined = params && removeEmptyParams(params)
  const queryParams = filteredParams
    ? `?${new URLSearchParams(filteredParams)}`
    : ''
  const url = `${PUBLIC_API_URL}${path}${queryParams}`

  const response = await window.fetch(url, {
    headers: {
      'content-type': 'application/json',
      ...headers,
    },
    ...fetchOptions,
    body: body && JSON.stringify(body),
    method,
  })

  const data = await response.json().catch(() => {
    const message = response.statusText
    throw new SerializationError(message)
  })

  if (!response.ok) {
    const message = data?.error || response.statusText
    throw new Error(message)
  }

  return data
}

/**
 * Function that removes keys with empty values from object.
 * @example removeEmptyParams({x: 'a', b: '', c: null}) => {x: 'a'}
 * */
function removeEmptyParams<T extends FetchParamsType>(params: T): T {
  return Object.keys(params)
    .filter((key) => !!params[key])
    .reduce((acc, key) => ({ ...acc, [key]: params[key] }), {}) as T
}

export type UseFetchData = Readonly<{
  method: FetchMethod
  path: string
}>

function useFetch<
  Response extends FetchResponseType,
  Data extends FetchDataType = any,
  Params extends FetchParamsType = any
>({ path, method }: UseFetchData) {
  const loadingState = writable<boolean>(false)

  const request = async ({ body, params }: { body?: Data; params?: Params }) => {
    loadingState.set(true)

    try {
      return await fetch<Response, Data, Params>(method, path, {
        body,
        params,
      })
    } finally {
      loadingState.set(false)
    }
  }

  return { fetch: request, isLoading: get(loadingState) }
}

export default useFetch
