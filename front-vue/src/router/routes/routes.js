import Vue from 'vue';
import store from './../../store/store';

import Root from './../../components/Root.vue';
import Home from './../../components/Home.vue';
import Career from './../../components/Career/main.vue';

import University from './../../components/University/main.vue';
import Information from './../../components/University/Information.vue';
import Careers from './../../components/University/Careers.vue';

import Search from './../../components/Search.vue';
import VueRouter from 'vue-router';

export default [
  {
    path: '/',
    component: Root,
    children: [
      { path: '', component: Home, name: 'home' },
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
      { path: '/search', component: Search, name: 'search' },
    ],
  },
];
