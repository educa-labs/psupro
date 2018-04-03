import Vue from 'vue';

export default {
  selectLocale(context, payload) {
    return new Promise(resolve => {
      context.commit('updateLocale', payload);

      resolve();
    });
  },
  fetchSearchResponse(context, { query, filters }) {
    return new Promise(resolve => {
      context.commit('updateSearch', { fetching: true });

      Vue.prototype.$API.search.search(query, filters, true).then(response => {
        context.commit('updateSearch', { query, response, fetching: false });

        resolve();
      });
    });
  },
  clearSearchResponse(context) {
    return new Promise(resolve => {
      context.commit('updateSearch', { response: '' });

      resolve();
    });
  },
  showOverlay(context, payload) {
    return new Promise(resolve => {
      context.commit('updateOverlay', { ...payload, show: true });

      resolve();
    });
  },
  hideOverlay(context) {
    return new Promise(resolve => {
      context.commit('updateOverlay', { show: false });

      resolve();
    });
  },
  stickHeader(context) {
    return new Promise(resolve => {
      context.commit('updateHeader', { sticky: true });

      resolve();
    });
  },
  unstickHeader(context) {
    return new Promise(resolve => {
      context.commit('updateHeader', { sticky: false });

      resolve();
    });
  },
  openHero(context) {
    return new Promise(resolve => {
      context.commit('updateHero', { open: true });

      resolve();
    });
  },
  closeHero(context) {
    return new Promise(resolve => {
      context.commit('updateHero', { open: false });

      resolve();
    });
  },
};
