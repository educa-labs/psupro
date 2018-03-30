import Vue from 'vue';

export default {
  updateHeavySearchResponse(state, payload) {
    state.heavySearchResponse = payload.response;
  },
  updateIsSearchBarFocused(state, payload) {
    state.isSearchBarFocused = payload.focus;
  },
  updateOverlay(state, payload) {
    state.overlay.show = payload.show;
    state.overlay.handleClick = payload.handleClick;
    state.overlay.zIndex = payload.zIndex;
  },
  updateHero(state, payload) {
    state.cHero.hidden = payload.hidden;
  },
  updateLocale(state, payload) {
    state.locale = state.locales[payload.locale];
  },
};
