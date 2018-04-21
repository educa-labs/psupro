import Vue from 'vue';
import VueMQ from 'vue-mq';

Vue.use(VueMQ, {
  breakpoints: {
    xs: 575.98,
    sm: 767.98,
    md: 991.98,
    lg: 1199.98,
    xl: Infinity,
  },
});
