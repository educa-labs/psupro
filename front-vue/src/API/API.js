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
  search: {
    careers(search, filters) {
      let body = { carreer: { text: search, ...filters } };

      return new Promise((resolve, reject) => {
        Vue.http.post(`${API.url}/search`, body).then(response => {
          resolve(preprocessors.search.careers(response.body));
        });
      });
    },
    universities(search, filters) {
      let body = { university: { text: search, ...filters } };

      return new Promise((resolve, reject) => {
        Vue.http.post(`${API.url}/search`, body).then(response => {
          resolve(preprocessors.search.universities(response.body));
        });
      });
    },
    search(search, filters) {
      return new Promise((resolve, reject) => {
        API.search.careers(search, filters).then(careers => {
          API.search.universities(search, filters).then(universities => {
            resolve(preprocessors.search.search(careers, universities));
          });
        });
      });
    },
  },
};

Vue.prototype.$API = API;

export default API;
