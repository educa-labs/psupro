import Trending from './../components/Trending.vue';
import Career from './../components/Career.vue';
import University from './../components/University.vue';
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
    name: 'university',
    props: route => ({ id: Number(route.params.id) }),
  },
  {
    path: '/search',
    component: SearchResponse,
    name: 'search',
  },
];
