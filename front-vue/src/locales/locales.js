import Vue from 'vue';

import en from './en'; // en
import esCL from './es-CL'; // es-CL

const locales = { en, esCL };

Vue.prototype.$locales = locales;

export default locales;
