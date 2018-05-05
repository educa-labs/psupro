<template>
  <div class="expandible" :class="{ open }"
    :style="{ 'max-height': _maxHeight }"
    @click="toggleOpen"
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
      overflowed: this.expandible,
      open: true,
    };
  },
  computed: {
    _maxHeight() {
      return this.open ? 'unset' : `${this.maxHeight}px`;
    },
  },
  methods: {
    toggleOpen() {
      if (this.expandible && this.overflowed) this.open = !this.open;
    },
  },
  mounted() {
    this.overflowed = this.$slots.default[0].elm.offsetHeight > this.maxHeight;

    if (this.overflowed) this.open = false;
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

  color: c-gray(600)

  @include icon(32px)

.expandible::after
  width: 100%
  height: 50%

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
