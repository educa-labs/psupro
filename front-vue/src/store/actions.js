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

      Vue.prototype.$API.search(query, filters, false, true).then(response => {
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
      context.commit('executeOverlayMethods');
      context.commit('updateOverlay', { show: false });

      resolve();
    });
  },
  mountOverlayComponent(context, payload) {
    return new Promise(resolve => {
      context.dispatch('unmountOverlayComponent').then(() => {
        context.commit('updateOverlayComponent', payload);

        context
          .dispatch('showOverlay', {
            method: () => {
              context.dispatch('unmountOverlayComponent');
            },
          })
          .then(resolve);
      });
    });
  },
  unmountOverlayComponent(context) {
    return new Promise(resolve => {
      context.commit('updateOverlayComponent', { is: '', payload: null });

      resolve();
    });
  },
};
