import { browser } from '$app/environment';
import { init, register } from 'svelte-i18n';

const defaultLocale = 'en';

register('en', () => import('./locales/en.json'));
register('ru', () => import('./locales/ru.json'));
if (browser) {
	console.log({ defaultLocale, navigator: window.navigator.language });
}

init({
	fallbackLocale: defaultLocale,
	initialLocale: browser ? window.navigator.language : defaultLocale
});
