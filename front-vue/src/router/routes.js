import Trending from './../components/Trending.vue';
import Career from './../components/Career.vue';

import University from './../components/University.vue';
import Information from './../components/University/Information.vue';
import Careers from './../components/University/Careers.vue';

import SearchResponse from './../components/SearchResponse.vue';

export default [
  {
    path: '/',
    component: Trending,
    name: 'trending',
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
      },
      {
        path: 'careers',
        component: Careers,
        name: 'careers',
      },
    ],
  },
  {
    path: '/search',
    component: SearchResponse,
    name: 'search',
  },
];
