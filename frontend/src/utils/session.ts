import { to } from '$lib/routes';
import { del } from '$utils/fetch';

export const logOut = async () => {
  await del('/v1/sign-out');
  localStorage.removeItem('user');
  window.location.href = to.signIn();
};
