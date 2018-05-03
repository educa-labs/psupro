import Vue from 'vue';
import VueRouter from 'vue-router';
import store from './../../store/store';

import Root from './../../components/Root.vue';
import Home from './../../components/Home.vue';

import Career from './../../components/Career/main.vue';
import CareerInformation from './../../components/Career/Information.vue';
import SimilarCareers from './../../components/Career/SimilarCareers.vue';

import University from './../../components/University/main.vue';
import UniversityInformation from './../../components/University/Information.vue';
import Careers from './../../components/University/Careers.vue';

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
        props: route => ({ id: Number(route.params.id) }),
        children: [
          {
            path: '',
            component: CareerInformation,
            name: 'career',
            props: route => ({ id: Number(route.params.id) }),
          },
          {
            path: 'similar-careers',
            component: SimilarCareers,
            name: 'similar-careers',
            props: route => ({ id: Number(route.params.id) }),
          },
        ],
      },
      {
        path: '/university/:id',
        component: University,
        props: route => ({ id: Number(route.params.id) }),
        children: [
          {
            path: '',
            component: UniversityInformation,
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
