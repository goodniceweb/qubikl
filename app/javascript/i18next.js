import i18next from 'i18next'
import translations from "./translations";
const i18n = i18next.init({
  fallbackLng: 'en',
  whitelist: ['en', 'ru'],
  ns: 'stimulus',
  defaultNS: 'stimulus',
  fallbackNS: 'stimulus',
  preload: true,
  resources: translations,
});

export { i18n as i18n }
