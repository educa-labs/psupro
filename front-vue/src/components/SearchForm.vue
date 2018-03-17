<template>
  <form @click="$refs.input.focus()">
    <div class="field z-depth-2" :class="{ active }">
      <div class="field-wrapper">
        <i class="material-icons">search</i>

        <input type="text" placeholder="Busca por ciudad, carrera o universidad"
          @focus="focusHandler"
          @blur="blurHandler"
          ref="input"
        >
      </div>

      <transition name="dropdown"
        @before-enter="beforeEnter"
        @after-leave="afterLeave"
      >
        <div class="field-results" v-if="$store.state.test"></div>
      </transition>
    </div>
  </form>
</template>

<script>
export default {
  data() {
    return {
      active: false,
    };
  },
  methods: {
    focusHandler() {
      this.$store.dispatch('test1');
    },
    blurHandler() {
      this.$store.dispatch('test2');
    },
    beforeEnter() {
      this.active = true;
    },
    afterLeave() {
      this.active = false;
    },
  },
};
</script>

<style lang="sass" scoped>
form
  cursor: pointer

  .field
    $border-radius: 2px

    .field-wrapper
      $padding: .75rem

      display: flex
      align-items: center

      padding: $padding

      border-radius: $border-radius

      background-color: #ffffff

      i
        margin-right: $padding

        color: #757575

      input
        box-sizing: border-box

        width: 100%
        height: 100%

        border: none
        outline: none

        font-size: medium

      input::placeholder
        color: #8C8C8C

    .field-results
      position: absolute
      z-index: 19999
      right: 1em
      left: 1em

      height: 100px

      border-top: 1px solid lightgray
      border-bottom-right-radius: $border-radius
      border-bottom-left-radius: $border-radius
      background-color: #ffffff

      &.dropdown-enter, &.dropdown-leave-to
        height: 0

      &.dropdown-enter-active, &.dropdown-leave-active
        transition: all .2s ease

  .field.active
    .field-wrapper
      border-bottom-right-radius: 0
      border-bottom-left-radius: 0
</style>
