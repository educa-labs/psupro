import Main from './../../components/Career/Main.vue';

export default {
  path: '/career/:id',
  component: Main,
  name: 'career',
  props: route => ({ id: Number(route.params.id) }),
};
