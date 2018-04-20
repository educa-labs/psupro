<template>
  <div class="navigator">
    <app-icon class="button" @click.native="back">arrow_back</app-icon> {{ name }}
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: '',
    };
  },
  methods: {
    back() {
      this.$router.go(-1);
    },
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
