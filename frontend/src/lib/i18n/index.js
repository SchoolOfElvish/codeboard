import {} from '$app/environment';
import { init, register } from 'svelte-i18n';
import { browser } from '$app/environment';

const supportedLocales = ['en', 'ru'];

function getDefaultLocale() {
  const browserLocale = typeof navigator !== 'undefined' ? navigator.language : 'en';

  if (supportedLocales.includes(browserLocale)) {
    return browserLocale;
  }

  const language = browserLocale.split('-')[0];
  const closestLocale = supportedLocales.find((locale) => locale.startsWith(language));
  if (closestLocale) {
    return closestLocale;
  }

  return supportedLocales[0];
}

const defaultLocale = getDefaultLocale();

register('en', () => import('./locales/en.json'));
register('ru', () => import('./locales/ru.json'));
if (browser) {
  console.log({ defaultLocale, navigator: window.navigator.language });
}

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
