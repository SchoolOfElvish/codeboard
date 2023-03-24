import { browser } from '$app/environment';
import { init, register } from 'svelte-i18n';

const defaultLocale = 'en';

register('en', () => import('./locales/en.json'));
register('ru', () => import('./locales/ru.json'));
if (browser) {
  console.log({ defaultLocale, navigator: window.navigator.language });
}

function localeValue() {
  let value = browser && window.localStorage.getItem('locale')
  if (value === null)
  {value = browser ? window.navigator.language : defaultLocale}
  };

 export var localeValueresult = localeValue();
  console.log(localeValueresult);

init({
  fallbackLocale: defaultLocale,
  initialLocale: localeValueresult
});




