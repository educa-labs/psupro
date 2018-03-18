export default {
  searchOn(context) {
    context.commit('searchOn');
  },
  searchOff(context) {
    context.commit('searchOff');
  },
  search(context, payload) {
    context.commit('search', payload);
  },
};
