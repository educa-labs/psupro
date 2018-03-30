<template>
  <form class="search-bar z-depth-2" :class="{ active, focused: focus }"
    @click="$refs.input.focus()"
  >
    <div class="input">
      <i class="material-icons">search</i>

      <input type="text" :placeholder="$l.cSearchBar.placeholder"
        v-model="search"
        @keypress.enter.prevent="keypressHandler"
        @input="handleInput"
        @focus="handleFocus"
        @blur="handleBlur"
        ref="input"
      >
    </div>

    <transition name="dropdown"
      @before-enter="beforeEnter"
      @after-leave="afterLeave"
      @enter="enter"
      @leave="leave"
    >
      <div class="search-response" 
        @mousedown.prevent
        v-if="focus"
      >
        <div v-if="response">
          <section v-if="response.universities.length > 0">
            <div>{{ $l.universities }}</div>

            <ul><li
              v-for="university in response.universities"
              :key="`university-${university.id}`"
            >
              <i class="material-icons">account_balance</i> {{ university.title }}
            </li></ul>
          </section>

          <section v-if="response.careers.length > 0">
            <div>{{ $l.careers }}</div>

            <ul><li
              v-for="career in response.careers"
              :key="`career-${career.id}`"
            >
              <i class="material-icons">school</i> {{ career.title }}
            </li></ul>
          </section>

          <div v-if="response.universities.length === 0 && response.careers.length === 0">{{ $l.empty }}</div>
        </div>

        <app-spinner v-else></app-spinner>
      </div>
    </transition>
  </form>
</template>

<script>
/*
TODO:
  - <Navigator>
  - Buscador recuerda búsqueda realizada
  - Títulos de secciones
  - Padding de sessiones
  - Tamaños de fuentes
  - Refactor
*/

export default {
  props: {
    delay: { type: Number, default: 250 },
  },
  data() {
    return {
      search: '',
      searchTimeout: null,
      response: null,

      active: false,
      focus: false,
    };
  },
  methods: {
    fetch() {
      this.response = null;

      this.$API.search.search(this.search).then(response => {
        this.response = response;
      });
    },
    handleFocus() {
      this.$store.dispatch('showOverlay', {
        handleClick: () => {
          this.$store.dispatch('hideOverlay');
        },
        zIndex: 1005,
      });

      this.focus = true;
    },
    handleBlur() {
      this.$store.dispatch('showOverlay');

      this.focus = false;
    },
    handleInput() {
      clearTimeout(this.searchTimeout);

      this.searchTimeout = setTimeout(() => {
        this.fetch();
      }, this.delay);
    },
    keypressHandler() {
      this.handleBlur();

      let payload = { query: this.search, image: true };
      this.$store.dispatch('fetchHeavySearch', payload).then(() => {
        this.$router.push({ name: 'search' });
      });
    },
    beforeEnter() {
      this.active = true;
    },
    afterLeave() {
      this.active = false;
    },
    enter(el, done) {
      let height = el.offsetHeight;

      el.style.height = 0 + 'px';

      this.$Anime({
        targets: el,
        height: height,
        duration: 250,
        easing: 'easeInOutQuad',
        complete: () => {
          el.style.overflowY = 'scroll';
          done();
        },
      });
    },
    leave(el, done) {
      el.style.overflowY = 'hidden';

      this.$Anime({
        targets: el,
        height: 0,
        duration: 250,
        easing: 'easeInOutQuad',
        complete: done,
      });
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.search-bar
  $border-radius: 2px

  position: relative

  z-index: 1010

  border-radius: $border-radius
  background-color: #FFFFFF

  .input
    $padding: .75rem

    display: flex
    align-items: center

    padding: $padding

    cursor: pointer

    i
      margin-right: $padding

      color: #757575 // Grey - 600

    input
      box-sizing: border-box

      width: 100%
      height: 100%

      border: none
      outline: none

      font-size: medium

    input::placeholder
      color: #757575 // Grey - 600

  .search-response
    position: absolute
    z-index: 1010
    right: 0
    left: 0

    cursor: default

    overflow-y: hidden

    border-top: 1px solid #F5F5F5
    border-bottom-right-radius: $border-radius
    border-bottom-left-radius: $border-radius
    background-color: #FFFFFF

    section div:first-child
      margin: .75rem 0 .75rem calc(24px + .75rem)

      color: #9E9E9E // Grey - 500

    & > div
      padding: 0 .75rem

      ul
        margin: 0
        padding: 0

        li
          display: flex
          align-items: center

          margin-bottom: .75rem

          color: #000000

          font-weight: 300

          i
            margin-right: .75rem

            color: #E0E0E0 // Grey - 300

.search-bar.active
  border-bottom-right-radius: 0
  border-bottom-left-radius: 0

.search-bar
  transition: transform 250ms

  &.focused
    transform: scale(1.006)
</style>
