import locales from './../locales/locales';

export default {
  locales,
  locale: locales.esCL,
  search: {
    query: '',
    response: null,
    fetching: false,
  },
  overlay: {
    show: false,
    handleClick: null,
    zIndex: 1000,
  },
};
