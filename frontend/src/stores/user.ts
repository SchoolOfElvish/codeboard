import { persisted } from '$lib/persisted';
import { get } from 'svelte/store';

interface User {
  email?: string;
  token?: string;
  refreshToken?: string;
}

const store = persisted<User>('user', {
  email: '',
  token: ''
});

const { subscribe, set } = store;

const createUserStore = () => {
  return {
    subscribe,
    set,
    isAuthorized: get(store).token ? true : false
  };
};

export default createUserStore();
