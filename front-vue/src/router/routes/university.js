import Main from './../../components/University/Main.vue';
import Information from './../../components/University/Information.vue';
import Careers from './../../components/University/Careers.vue';

export default {
  path: '/university/:id',
  component: Main,
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
};
