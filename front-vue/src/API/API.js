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
    careers(query, filters, image = false) {
      let body = { carreer: { text: query, ...filters } };

      return new Promise((resolve, reject) => {
        Vue.http.post(`${API.url}/search`, body).then(response => {
          let careers = response.body;

          if (image) {
            let promises = careers.map(career => {
              return API.universities(career.university_id, {
                params: { image: true },
              }).then(response => {
                career.image = response.profile;
              });
            });

            Promise.all(promises).then(() => {
              resolve(preprocessors.search.careers(careers));
            });
          } else resolve(preprocessors.search.careers(careers));
        });
      });
    },
    universities(query, filters, image = false) {
      let body = { university: { text: query, ...filters } };

      return new Promise((resolve, reject) => {
        Vue.http.post(`${API.url}/search`, body).then(response => {
          let universities = response.body;

          if (image) {
            let promises = universities.map(university => {
              return API.universities(university.id, {
                params: { image: true },
              }).then(response => {
                university.image = response.cover;
              });
            });

            Promise.all(promises).then(() => {
              resolve(preprocessors.search.universities(universities));
            });
          } else resolve(preprocessors.search.universities(universities));
        });
      });
    },
    search(query, filters, image = false) {
      return new Promise((resolve, reject) => {
        API.search.careers(query, filters, image).then(careers => {
          API.search.universities(query, filters, image).then(universities => {
            resolve(preprocessors.search.search(careers, universities));
          });
        });
      });
    },
  },
};

export default API;
