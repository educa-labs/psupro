import Vue from 'vue'; // Vue
import API from './API/API'; // VueResource
import router from './router/router'; // VueRouter
import store from './store/store'; // Vuex

require('./stylesheets'); // Stylesheets

import App from './App.vue';

new Vue({ el: '#app', router, store, render: h => h(App) });
