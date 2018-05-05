<template>
  <transition name="fade">
    <ul class="select-options">
      <li class="disabled">{{ $l.cSelect.tip }}</li>

      <li v-for="(option, index) in options" :key="`option-${index}`"
        @click="_handleOptionClick(index)"
      >{{ option.key }}</li>
    </ul>
  </transition>
</template>

<script>
export default {
  props: {
    options: {
      type: Array,
      required: true,
    },
    handleOptionClick: {
      type: Function,
      required: true,
    },
  },
  methods: {
    _handleOptionClick(index) {
      this.handleOptionClick(index);

      this.$store.dispatch('unmountOverlayComponent');
    },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.select-options
  overflow-y: scroll

  max-height: 200px

  transform: translate(0, -50%)

  color: $c-black

  @include media-up(sm)
    width: $breakpoint-sm

    transform: translate(-50%, -50%)

    @include p-fixed(null, 50%, null, null, 50%)

  @include canvas
  @include p-fixed(null, 50%, 1rem, null, 1rem)

  & > li
    padding: 14px 16px

    cursor: pointer

    &:focus, &:hover
      background-color: rgba(0, 0, 0, .08)
  
  & > li.disabled
    cursor: default

    color: c-gray(500)

    &:focus, &:hover
      background-color: unset

  &.fade-enter, &.fade-leave-to
    opacity: 0

  &.fade-enter-active
    transition: opacity .2s

  &.fade-leave-active
    transition: opacity .1s
</style>
