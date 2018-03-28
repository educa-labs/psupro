import Vue from 'vue';

export default {
  fetchHeavySearch(context, payload) {
    return new Promise(resolve => {
      Vue.prototype.$API.search
        .search(payload.query, payload.filters, payload.image)
        .then(response => {
          console.log(response);
          context.commit('updateHeavySearchResponse', { response });

          resolve();
        });
    });
  },
  updateIsSearchBarFocused(context, payload) {
    context.commit('updateIsSearchBarFocused', payload);
  },
  updateTest(context, payload) {
    context.commit('updateTest', payload);
  },
  selectLocale(context, payload) {
    context.commit('updateLocale', payload);
  },
};
