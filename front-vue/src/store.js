import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    test: false,
  },
  mutations: {
    test1(state) {
      state.test = true;
    },
    test2(state) {
      state.test = false;
    },
  },
  actions: {
    test1(context) {
      context.commit('test1');
    },
    test2(context) {
      context.commit('test2');
    },
  },
});
