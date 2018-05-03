<template>
  <div class="navigator">
    <app-back-button v-if="buttons.back"></app-back-button> {{ name }}
  </div>
</template>

<script>
export default {
  props: {
    buttons: {
      type: Object,
      default: { back: true },
    },
  },
  data() {
    return {
      name: '',
    };
  },
  beforeMount() {
    this.name = this.$l.cNavigator[this.$route.name];
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.navigator
  $padding: 1rem

  padding: $padding

  color: $c-white
  background-color: $c-main

  font-size: $f-large

  @include d-flex(center)

  .icon
    @include icon(24px, $padding)
</style>
