import locales from './../locales/locales'; // Locales

export default {
  heavySearchResponse: null,
  isSearchBarFocused: false,
  overlay: {
    show: false,
    handleClick: () => {},
    zIndex: 1000,
  },
  test: false,

  locales,
  locale: locales.esCL,
};
