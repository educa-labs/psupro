import Vue from 'vue';
import VueResource from 'vue-resource';

Vue.use(VueResource);

// Preprocessors for each API endpoint
import preprocessors from './preprocessors';

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
      Vue.http
        .get(`${API.url}/carreers/${id}`, config)
        .then(response => {
          resolve(preprocessors.careers(response.body));
        })
        .catch(error => reject(error));
    });
  },
  universities: {
    universities(id, config) {
      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/universities/${id}`, config)
          .then(response => {
            resolve(preprocessors.universities.universities(response.body, config));
          })
          .catch(error => reject(error));
      });
    },
    campus(id) {
      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/universities/${id}/campus`)
          .then(response =>
            resolve(preprocessors.universities.campus(response.body))
          )
          .catch(error => reject(error));
      });
    },
    careers(id) {
      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/universities/${id}/carreers`)
          .then(response =>
            resolve(preprocessors.universities.careers(response.body))
          )
          .catch(error => reject(error));
      });
    },
  },
  search(query, filters = null, minimize = false, pictures = false) {
    let params = { text: query, ...filters, minimize, pictures };

    return new Promise((resolve, reject) => {
      Vue.http
        .get(`${API.url}/search`, { params })
        .then(response => resolve(preprocessors.search(response.body)))
        .catch(error => reject(error));
    });
  },
  constants: {
    cities() {
      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/cities`)
          .then(response =>
            resolve(preprocessors.constants.cities(response.body))
          )
          .catch(error => reject(error));
      });
    },
    degreeTypes() {
      let API_response = [
        { id: 1, title: 'Profesional' },
        { id: 2, title: 'Técnica' },
      ];

      return new Promise((resolve, reject) =>
        resolve(preprocessors.constants.degreeTypes(API_response))
      );
    },
    regions() {
      return new Promise((resolve, reject) => {
        Vue.http
          .get(`${API.url}/regions`)
          .then(response =>
            resolve(preprocessors.constants.regions(response.body))
          )
          .catch(error => reject(error));
      });
    },
  },
};

export default API;
