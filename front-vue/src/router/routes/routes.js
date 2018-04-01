import Vue from 'vue';
import store from './../../store/store';

import Home from './../../components/Home.vue';

import careerRoutes from './career';
import universityRoutes from './university';

import Search from './../../components/Search.vue';

export default [
  {
    path: '/',
    component: Home,
    name: 'home',
  },
  careerRoutes,
  universityRoutes,
  {
    path: '/search',
    component: Search,
    name: 'search',
    beforeEnter: (to, from, next) => {
      store.dispatch('hideHero');

      next();
    },
    beforeLeave: (to, from, next) => {
      store.dispatch('showHero');

      next();
    },
  },
];
