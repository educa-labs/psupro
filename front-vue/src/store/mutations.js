import Vue from 'vue';

export default {
  updateLocale(state, payload) {
    state.locale = state.locales[payload.locale];
  },
  updateHeavySearchResponse(state, payload) {
    state.heavySearchResponse = payload.response;
  },
  updateOverlay(state, payload) {
    state.overlay.show = payload.show;
    state.overlay.handleClick = payload.handleClick;
    state.overlay.zIndex = payload.zIndex;
  },
  updateHero(state, payload) {
    state.cHero.open = payload.open;
  },
};
