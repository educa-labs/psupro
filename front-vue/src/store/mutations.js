import Vue from 'vue';

export default {
  updateLocale(state, payload) {
    state.locale = state.locales[payload.locale];
  },
  updateSearch(state, payload) {
    state.search = Object.assign(state.search, payload);
  },
  updateOverlay(state, payload) {
    let { method, ..._payload } = payload;

    state.overlay = Object.assign(state.overlay, _payload);

    if (method) state.overlay.stack.push(method);
  },
  executeOverlayMethods(state) {
    let stack = state.overlay.stack;

    while (stack.length) stack.pop()();
  },
  updateOverlayComponent(state, payload) {
    state.overlay.component = Object.assign(state.overlay.component, payload);
  },
};
