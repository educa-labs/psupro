import Vue from 'vue';

export default {
  searchOn(state) {
    state.searching = true;
  },
  searchOff(state) {
    state.searching = false;
  },
  search(state, payload) {
    state.searchFetched = false;

    Vue.prototype.$API.search
      .search(payload.search, payload.filters, payload.image)
      .then(response => {
        state.search = response;
        state.searchFetched = true;
      });
  },
};
