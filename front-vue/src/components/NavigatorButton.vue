<template>
  <app-icon class="navigator-button" @click.native="push">
    <slot></slot>
  </app-icon>
</template>

<script>
export default {
  props: {
    name: { type: String, default: 'home' },
  },
  methods: {
    push() {
      this.$router.push({ name: this.name });
    },
  },
};
</script>

<style lang="sass" scoped>
.navigator-button
  cursor: pointer !important
</style>
