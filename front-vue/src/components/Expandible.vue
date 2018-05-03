<template>
  <div class="expandible" :class="{ open }"
    :style="{ 'max-height': _maxHeight }"
    @click="open = !open"
  >
    <slot></slot>

    <app-icon class="chevron" v-if="expandible">chevron_right</app-icon>
  </div>
</template>

<script>
export default {
  props: {
    expandible: { type: Boolean, default: true },
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
  methods: {
    toggleOpen() {
      if (this.expandible) this.open = !this.open;
    },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.expandible
  overflow: hidden

  cursor: pointer

  @include d-flex
  @include p-relative

.expandible > .chevron
  margin-top: auto
  margin-bottom: auto

  transition: transform .2s

  @include icon(32px)

.expandible::after
  width: 100%
  height: 20px

  content: ''

  background: linear-gradient(transparent, $c-white)

  @include p-absolute(null, null, null, 0)

.expandible.open
  cursor: default

.expandible.open > .chevron
  display: none

.expandible.open::after
  display: none
</style>
