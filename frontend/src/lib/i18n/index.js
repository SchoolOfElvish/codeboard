import {} from '$app/environment';
import { init, register } from 'svelte-i18n';
import { browser } from '$app/environment';

const defaultLocale = 'en';

register('en', () => import('./locales/en.json'));
register('ru', () => import('./locales/ru.json'));

export function localeStoragevalue() {
  let localevalue = browser ? window.localStorage.getItem('locale') : null;
  if (localevalue === null) {
    localevalue = browser ? window.navigator.language : defaultLocale;
  }
  return localevalue;
}

init({
  fallbackLocale: defaultLocale,
  initialLocale: localeStoragevalue()
});
