<template>
  <form @click="$refs.input.focus()">
    <div class="field z-depth-2" :class="{ active }">
      <div class="field-wrapper">
        <i class="material-icons">search</i>

        <input type="text" placeholder="Busca por ciudad, carrera o universidad"
          v-model="search"
          @focus="focusHandler"
          @blur="blurHandler"
          @input="inputHandler"
          ref="input"
        >
      </div>

      <transition name="dropdown"
        @before-enter="beforeEnter"
        @after-leave="afterLeave"
      >
        <div class="field-results" v-if="$store.state.test">
          <section>
            <h5 class="title">Universidades</h5>

            <div v-for="university in $store.state.search.universities" :key="university.id">{{ university.title }}</div>
          </section>
          <section>
            <h5 class="title">Carreras</h5>

            <div v-for="career in $store.state.search.careers" :key="career.id">{{ career.title }}</div>
          </section>
        </div>
      </transition>
    </div>
  </form>
</template>

<script>
export default {
  props: {
    delay: { type: Number, default: 250 },
  },
  data() {
    return {
      search: '',
      searchTimeout: null,

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
    inputHandler() {
      clearTimeout(this.searchTimeout);

      this.searchTimeout = setTimeout(() => {
        this.$store.dispatch('search', { search: this.search });
      }, this.delay);
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

      min-height: 100px

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
