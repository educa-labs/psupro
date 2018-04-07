import Vue from 'vue';
import VueResource from 'vue-resource';

Vue.use(VueResource);

import preprocessors from './preprocessors'; // Preprocessors

const API = {
  url: 'http://localhost:3000',
  popular: {
    careers(limit = 4) {
      let params = { limit };

      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/popular/carreers`, { params })
          .then(response => {
            resolve(response.body);
          })
          .catch(error => reject(error));
      });
    },
    universities(limit = 4) {
      let params = { limit };

      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/popular/universities`, { params })
          .then(response => {
            resolve(response.body);
          })
          .catch(error => reject(error));
      });
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
    search(query, filters = null, minimize = false, pictures = false) {
      let params = { text: query, minimize, pictures };

      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/search`, { params })
          .then(response =>
            resolve(preprocessors.search.search(response.body))
          )
          .catch(error => reject(error));
      });
    },
  },
  regions() {
    return new Promise((resolve, reject) => {
      Vue.http.get(`${API.url}/regions`).then(response => {
        resolve(preprocessors.regions(response.body));
      });
    });
  },
  cities() {
    return new Promise((resolve, reject) => {
      Vue.http.get(`${API.url}/cities`).then(response => {
        resolve(preprocessors.cities(response.body));
      });
    });
  },
  test(id) {
    return new Promise((resolve, reject) => {
      Vue.http.get(`${API.url}/universities/${id}/carreers`).then(response => {
        resolve(response.body);
      });
    });
  },
  campus: {
    byUniversity(id) {
      return new Promise((resolve, reject) => {
        Vue.http.get(`${API.url}/universities/${id}/campus`).then(response => {
          resolve(response.body);
        });
      });
    },
  },
};

export default API;
