import Vue from 'vue';

export default {
  selectLocale(context, payload) {
    return new Promise(resolve => {
      context.commit('updateLocale', payload);

      resolve();
    });
  },
  fetchHeavySearch(context, payload) {
    return new Promise(resolve => {
      Vue.prototype.$API.search
        .search(payload.query, payload.filters, payload.image)
        .then(response => {
          context.commit('updateHeavySearchResponse', { response });

          resolve();
        });
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
  showHero(context) {
    return new Promise(resolve => {
      context.commit('updateHero', { hidden: false });

      resolve();
    });
  },
  hideHero(context) {
    return new Promise(resolve => {
      context.commit('updateHero', { hidden: true });

      resolve();
    });
  },
};
