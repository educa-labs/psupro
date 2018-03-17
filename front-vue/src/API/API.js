import Vue from 'vue';
import VueResource from 'vue-resource';

Vue.use(VueResource);

import preprocessors from './preprocessors'; // Preprocessors

const API = {
  url: 'https://tuni.educalabs.cl',
  popular: {
    careers() {
      return Vue.http.get(`${API.url}/popular/carreers`);
    },
    universities() {
      return Vue.http.get(`${API.url}/popular/universities`);
    },
  },
  careers(id, config) {
    return new Promise((resolve, reject) => {
      Vue.http.get(`${API.url}/carreers/${id}`, config).then(response => {
        resolve(preprocessors.careers(response.body));
      });
    });
  },
  universities(id, config) {
    return new Promise((resolve, reject) => {
      Vue.http.get(`${API.url}/universities/${id}`, config).then(response => {
        resolve(preprocessors.universities(response.body));
      });
    });
  },
};

Vue.prototype.$API = API;

export default API;
