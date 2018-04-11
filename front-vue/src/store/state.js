import locales from './../locales/locales';

export default {
  locales,
  locale: locales.esCL,
  search: { query: '', response: null, fetching: false },
  overlay: {
    show: false,
    stack: [],
    zIndex: 1000,
    component: { is: '', payload: null },
  },
};
