// Internal
import Vue from 'vue'; // Vue
import API from './API/API'; // VueResource
import locales from './locales/locales'; // Locales
import router from './router/router'; // VueRouter
import store from './store/store'; // Vuex
import './stylesheets'; // Stylesheets

// External
import Anime from 'animejs';

Vue.prototype.$API = API;
Vue.prototype.$Anime = Anime;
Vue.prototype.$l = store.state.locale; // Abbreviation

import App from './App.vue';

import Spinner from './components/Spinner.vue';
Vue.component('app-spinner', Spinner);

new Vue({ el: '#app', router, store, render: h => h(App) });
