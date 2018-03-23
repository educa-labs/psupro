import Vue from 'vue';

export default {
  updateHeavySearchResponse(state, payload) {
    state.heavySearchResponse = payload.response;
  },
  updateIsSearchBarFocused(state, payload) {
    state.isSearchBarFocused = payload.focus;
  },
};
