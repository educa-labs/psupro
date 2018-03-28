import Vue from 'vue';

import en from './en'; // en
import esCL from './es-CL'; // es-CL

const locales = { en, esCL };

Vue.prototype.$locales = locales;
Vue.prototype.$l = Vue.prototype.$locales.esCL; // Abbreviation

export default locales;
