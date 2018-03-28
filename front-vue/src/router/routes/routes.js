import Vue from 'vue';
import store from './../../store/store';

import Home from './../../components/Home.vue';

import careerRoutes from './career';
import universityRoutes from './university';

import SearchResponse from './../../components/SearchResponse.vue';

export default [
  {
    path: '/',
    component: Home,
    name: 'trending',
    beforeEnter: (to, from, next) => {
      store.dispatch('updateTest', { test: false });

      next();
    },
    beforeLeave: (to, from, next) => {
      store.dispatch('updateTest', { test: true });

      next();
    },
  },
  careerRoutes,
  universityRoutes,
  {
    path: '/search',
    component: SearchResponse,
    name: 'search',
  },
];
