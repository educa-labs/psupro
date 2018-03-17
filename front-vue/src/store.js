import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    test: false,
    search: null,
  },
  mutations: {
    test1(state) {
      state.test = true;
    },
    test2(state) {
      state.test = false;
    },
    search(state, { search, filters }) {
      Vue.prototype.$API.search.search(search, filters).then(response => {
        state.search = response;

        console.log(response);
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
