<template>
  <div class="expandible" :class="{ open }"
    :style="{ 'max-height': _maxHeight }"
    @click="open = !open"
  >
    <slot></slot>

    <app-icon>chevron_right</app-icon>
  </div>
</template>

<script>
export default {
  props: {
    maxHeight: { type: Number, default: 100 },
  },
  data() {
    return {
      open: false,
    };
  },
  computed: {
    _maxHeight() {
      return this.open ? 'unset' : `${this.maxHeight}px`;
    },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.expandible
  overflow: hidden

  cursor: pointer

  @include p-relative
  @include d-flex

  .icon
    margin-top: auto
    margin-bottom: auto

.expandible::after
  width: 100%
  height: 20px

  content: ''

  background: linear-gradient(transparent, $c-white)

  @include p-absolute(null, null, null, 0)

.expandible.open
  cursor: default

  .icon
    display: none

.expandible.open::after
  display: none
</style>
