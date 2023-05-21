import { init, register } from 'svelte-i18n';
import { browser } from '$app/environment';

const defaultLocale = 'en';

register('en', () => import('./locales/en.json'));
register('ru', () => import('./locales/ru.json'));

const savedLocale = browser ? window.localStorage.getItem('locale') : null;

export function defineLocale() {
  if (savedLocale) {
    return savedLocale;
  }

  return browser ? window.navigator.language : defaultLocale;
}

init({
  fallbackLocale: defaultLocale,
  initialLocale: defineLocale()
});
