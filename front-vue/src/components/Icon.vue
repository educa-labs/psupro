<template>
  <i class="material-icons icon" :class="{ button }"><slot></slot></i>
</template>

<script>
export default {
  props: {
    button: { type: Boolean, default: false },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.icon
  cursor: default

  &.button
    cursor: pointer
</style>
