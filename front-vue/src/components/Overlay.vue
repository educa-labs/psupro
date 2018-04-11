<template>
  <div class="overlay" :style="{ 'z-index': $store.state.overlay.zIndex }"
    @click="$store.dispatch('hideOverlay')"
    v-if="$store.state.overlay.show"
  >
    <component :is="$store.state.overlay.component.is"
      v-bind="$store.state.overlay.component.payload"
      :style="{ 'z-index': $store.state.overlay.zIndex }"
      @click.native.stop
    ></component>
  </div>
</template>

<script>
import SelectOptions from './SelectOptions.vue';

export default {
  components: {
    'app-select-options': SelectOptions,
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.overlay
  opacity: .66
  background-color: $c-black

  @include p-fixed(null, 0, 0, 0, 0)
</style>
