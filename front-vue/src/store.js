import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    test: false,
    search: null,
    searchFetched: false,
  },
  mutations: {
    test1(state) {
      state.test = true;
    },
    test2(state) {
      state.test = false;
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
  },
  actions: {
    test1(context) {
      context.commit('test1');
    },
    test2(context) {
      context.commit('test2');
    },
    search(context, payload) {
      context.commit('search', payload);
    },
  },
});
