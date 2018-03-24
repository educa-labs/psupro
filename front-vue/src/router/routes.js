import Vue from 'vue';
import store from './../store/store'; // Vuex

import Trending from './../components/Trending.vue';
import Career from './../components/Career.vue';

import University from './../components/University/Main.vue';
import Information from './../components/University/Information.vue';
import Careers from './../components/University/Careers.vue';

import SearchResponse from './../components/SearchResponse.vue';

export default [
  {
    path: '/',
    component: Trending,
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
  {
    path: '/career/:id',
    component: Career,
    name: 'career',
    props: route => ({ id: Number(route.params.id) }),
  },
  {
    path: '/university/:id',
    component: University,
    props: route => ({ id: Number(route.params.id) }),
    children: [
      {
        path: '',
        component: Information,
        name: 'university',
        props: route => ({ id: Number(route.params.id) }),
      },
      {
        path: 'careers',
        component: Careers,
        name: 'careers',
        props: route => ({ id: Number(route.params.id) }),
      },
    ],
  },
  {
    path: '/search',
    component: SearchResponse,
    name: 'search',
  },
];
