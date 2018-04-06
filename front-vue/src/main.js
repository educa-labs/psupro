// Internal
import Vue from 'vue'; // Vue
import API from './API/API'; // VueResource
import formatter from './assets/javascripts/formatter';
import locales from './locales/locales'; // Locales
import router from './router/router'; // VueRouter
import store from './store/store'; // Vuex
import './responsiveness'; // VueMQ
import './stylesheets'; // Stylesheets

// External
import anime from 'animejs'; // AnimeJS

Vue.prototype.$API = API;
Vue.prototype.$a = anime; // Abbreviation
Vue.prototype.$f = formatter; // Abbreviation
Vue.prototype.$l = store.state.locale; // Abbreviation

import App from './App.vue';

import Hero from './components/Hero.vue';
Vue.component('app-hero', Hero);

import Icon from './components/Icon.vue';
Vue.component('app-icon', Icon);

import Navigator from './components/Navigator.vue';
Vue.component('app-navigator', Navigator);

import Spinner from './components/Spinner.vue';
Vue.component('app-spinner', Spinner);

new Vue({ el: '#app', router, store, render: h => h(App) });
