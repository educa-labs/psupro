import locales from './../locales/locales'; // Locales

export default {
  heavySearchResponse: null,
  isSearchBarFocused: false,
  overlay: {
    show: false,
    handleClick: () => {},
    zIndex: 1000,
  },
  cHero: {
    hidden: false,
  },
  locales,
  locale: locales.esCL,
};
