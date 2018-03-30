import Vue from 'vue';

export default {
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
  updateIsSearchBarFocused(context, payload) {
    context.commit('updateIsSearchBarFocused', payload);
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
    context.commit('updateHero', { hidden: false });
  },
  hideHero(context) {
    context.commit('updateHero', { hidden: true });
  },
  selectLocale(context, payload) {
    context.commit('updateLocale', payload);
  },
};
