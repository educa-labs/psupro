import Vue from 'vue';
import store from './../../store/store';

import Root from './../../components/Root.vue';
import Home from './../../components/Home.vue';
import Career from './../../components/Career/Main.vue';
import University from './../../components/University/Main.vue';
import Search from './../../components/Search.vue';

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
        name: 'university',
        props: route => ({ id: Number(route.params.id) }),
      },
      { path: '/search', component: Search, name: 'search' },
    ],
  },
];
