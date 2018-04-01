<template>
  <form class="search-bar z-depth-2" :class="{ focused, opening, searching }"
    @click="$refs.input.focus()"
    v-if="visible"
  >
    <div class="input">
      <app-icon v-if="search.query.length === 0">search</app-icon>
      <app-icon @click.native="search.query = ''" v-else>arrow_back</app-icon>

      <input type="text" :placeholder="$l.cSearchBar.placeholder"
        v-model="search.query"
        @keypress.enter.prevent="fetchHeavySearch"
        @focus="focus" @blur="unfocus"
        ref="input"
      >
    </div>

    <transition
      @before-enter="beforeEnter" @after-leave="afterLeave"
      @enter="enter" @leave="leave"
    >
      <div class="search-response" @mousedown.prevent v-if="focused">
        <template v-if="search.response">
          <section v-if="search.response.universities.length > 0">
            <div>{{ $l.universities }}</div>

            <ul><li v-for="university in search.response.universities" :key="`university-${university.id}`">
              <i class="material-icons">account_balance</i> {{ university.title }}
            </li></ul>
          </section>

          <section v-if="search.response.careers.length > 0">
            <div>{{ $l.careers }}</div>

            <ul><li v-for="career in search.response.careers" :key="`career-${career.id}`">
              <i class="material-icons">school</i> {{ career.title }}
            </li></ul>
          </section>

          <div class="empty" v-if="emptySearchResponse">{{ $l.empty }}</div>
        </template>

        <app-spinner v-else></app-spinner>
      </div>
    </transition>
  </form>
</template>

<script>
export default {
  props: {
    delay: { type: Number, default: 250 },
  },
  data() {
    return {
      search: {
        query: '',
        response: null,
        timeout: null,
      },

      focused: false,
      opening: false,
      searching: false,

      routesVisible: ['home', 'search'],
    };
  },
  watch: {
    'search.query': function() {
      clearTimeout(this.search.timeout);

      this.search.timeout = setTimeout(
        () => this.fetchLightSearch(),
        this.delay
      );
    },
  },
  computed: {
    emptySearchResponse() {
      return (
        this.search.response.universities.length === 0 &&
        this.search.response.careers.length === 0
      );
    },
    visible() {
      return this.routesVisible.includes(this.$route.name);
    },
  },
  methods: {
    fetchLightSearch() {
      this.search.response = null;

      this.$API.search.search(this.search.query).then(response => {
        this.search.response = response;
      });
    },
    fetchHeavySearch() {
      let payload = { query: this.search.query, image: true };

      this.$store.dispatch('fetchHeavySearch', payload).then(() => {
        this.$router.push({ name: 'search' });

        this.searching = false;
      });

      this.unfocus();

      this.searching = true;
    },
    focus() {
      let payload = { handleClick: this.unfocus, zIndex: 1005 };

      this.$store
        .dispatch('showOverlay', payload)
        .then(() => (this.focused = true));
    },
    unfocus() {
      this.$store.dispatch('hideOverlay').then(() => (this.focused = false));
    },
    beforeEnter() {
      this.opening = true;
    },
    afterLeave() {
      this.opening = false;
    },
    enter(el, done) {
      let height = el.offsetHeight;

      el.style.height = 0;
      el.style.overflowY = 'hidden';

      this.$a({
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

      this.$a({
        targets: el,
        height: 0,
        duration: 250,
        easing: 'easeInOutQuad',
        complete: done,
      });
    },
  },
  created() {
    this.fetchLightSearch();
  },
};
</script>

<style lang="sass" scoped>
.search-bar
  $border-radius: 2px
  $height: 48px

  position: relative
  z-index: 1010

  height: $height

  border-radius: $border-radius
  background-color: #FFFFFF

  .input
    $padding: .75rem

    display: flex
    align-items: center

    box-sizing: border-box

    height: 100%

    padding: $padding

    cursor: pointer

    .material-icons
      margin-right: $padding

      color: #757575

    input
      width: 100%

      font-size: 1em

    input::placeholder
      color: #757575

  .search-response
    border-bottom-right-radius: $border-radius
    border-bottom-left-radius: $border-radius

.search-bar.opening
  border-bottom-right-radius: 0
  border-bottom-left-radius: 0

.search-bar.searching
  animation: loading 2s infinite

  @keyframes loading
    0%
      opacity: 1
    66% 
      opacity: .75
    100%
      opacity: 1

.search-response
  $maxHeight: 200px
  $size: 24px

  position: absolute
  z-index: 1010
  right: 0
  left: 0

  overflow-y: scroll

  max-height: $maxHeight

  padding: 0 .75rem

  cursor: default

  border-top: 1px solid #F5F5F5
  background-color: #FFFFFF

  section div:first-child
    padding: .75rem 0 .75rem calc(#{$size} + .75rem)

    color: #9E9E9E

  li
    display: flex
    align-items: center

    margin-bottom: .75rem

    color: #000000

    font-weight: 300

    .material-icons
      width: $size
      height: $size

      margin-right: .75rem
</style>
