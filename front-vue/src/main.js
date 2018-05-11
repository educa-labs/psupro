import './assets/javascripts/global'; // Global configuration

// Internal
import Vue from 'vue'; // Vue
import API from './API/API'; // VueResource
import formatter from './assets/javascripts/formatter'; // Formatter
import locales from './locales/locales'; // Locales
import router from './router/router'; // VueRouter
import store from './store/store'; // Vuex
import './assets/stylesheets/grid.min.css'; // Grid Framework
import './assets/stylesheets/main.sass'; // Stylesheets
import './responsiveness'; // VueMQ

// External
import anime from 'animejs'; // AnimeJS

Vue.prototype.$API = API;
Vue.prototype.$a = anime; // Abbreviation
Vue.prototype.$f = formatter; // Abbreviation
Vue.prototype.$l = store.state.locale; // Abbreviation

import App from './App.vue';

import BackButton from './components/global/BackButton.vue';
Vue.component('app-back-button', BackButton);

import Hero from './components/global/Hero.vue';
Vue.component('app-hero', Hero);

import Icon from './components/global/Icon.vue';
Vue.component('app-icon', Icon);

import Navigator from './components/global/Navigator.vue';
Vue.component('app-navigator', Navigator);

import NavigatorButton from './components/global/NavigatorButton.vue';
Vue.component('app-navigator-button', NavigatorButton);

import Spinner from './components/global/Spinner.vue';
Vue.component('app-spinner', Spinner);

new Vue({ el: '#app', router, store, render: h => h(App) });
