import Vue from 'vue';

export default {
  updateLocale(state, payload) {
    state.locale = state.locales[payload.locale];
  },
  updateSearch(state, payload) {
    state.search = Object.assign(state.search, payload);
  },
  updateOverlay(state, payload) {
    state.overlay = Object.assign(state.overlay, payload);
  },
  updateHeader(state, payload) {
    state.header = Object.assign(state.header, payload);
  },
  updateHero(state, payload) {
    state.cHero = Object.assign(state.cHero, payload);
  },
};
