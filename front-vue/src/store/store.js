import Vue from 'vue';
import Vuex from 'vuex';

Vue.use(Vuex);

import state from './state'; // State
import actions from './actions'; // Actions
import mutations from './mutations'; // Mutations

export default new Vuex.Store({ state, actions, mutations });
