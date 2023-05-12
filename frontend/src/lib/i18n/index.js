import {} from '$app/environment';
import { init, register } from 'svelte-i18n';
import { browser } from '$app/environment';

const defaultLocale = 'en';

register('en', () => import('./locales/en.json'));
register('ru', () => import('./locales/ru.json'));

function localeValue() {
  let value = browser && window.localStorage.getItem('locale');
  if (value === null) {
    value = browser ? window.navigator.language : defaultLocale;
  }
  return value;
}

init({
  fallbackLocale: defaultLocale,
  initialLocale: localeValue() 
}); 
