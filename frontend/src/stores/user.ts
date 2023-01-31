import { writable } from 'svelte/store';
import { browser } from '$app/environment';

interface User {
  email?: string;
  token?: string;
  refreshToken?: string;
}

let fromLocalStorage: User = {};
if (browser) {
  fromLocalStorage = JSON.parse(localStorage.getItem('user') || '{}');
}

const store = writable<User>(fromLocalStorage || { email: '', token: '' });

const { subscribe, set, update } = store;

const setToken = (token: string) => {
  update((store) => ({ ...store, token }));
};

const setRefreshToken = (refreshToken: string) => {
  update((store) => ({ ...store, refreshToken }));
};

const createUserStore = () => {
  return {
    subscribe,
    set,
    setToken,
    setRefreshToken
  };
};

const userStore = createUserStore();

export default userStore;

if (browser) {
  userStore.subscribe((value) => (localStorage.user = JSON.stringify(value)));
}
