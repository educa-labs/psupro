<template>
  <form class="search-bar z-depth-2" :class="{ focused, opening }">
    <div class="input">
      <!-- <app-back-button v-if="$route.name === 'search'"></app-back-button> -->
      <app-icon>search</app-icon>

      <input type="text" :placeholder="$l.cSearchBar.placeholder"
        v-model="search.query"
        @keypress.enter.prevent="fetchHeavySearchResponse"
        @focus="focus" @blur="unfocus"
        ref="input"
      >

      <app-icon
        @click.native="search.query = ''"
        @mousedown.native.prevent
        v-if="search.query.length !== 0"
      >clear</app-icon>
    </div>

    <transition
      @before-enter="beforeEnter" @after-leave="afterLeave"
      @enter="enter" @leave="leave"
    >
      <div class="search-response" @mousedown.prevent v-if="focused">
        <template v-if="search.response">
          <section v-if="search.response.careers.length > 0">
            <div>{{ $l.careers }}</div>

            <ul><li v-for="career in search.response.careers.slice(0, 5)" :key="`career-${career.id}`">
              <router-link :to="{ name: 'career', params: { id: career.id }}">
                <app-icon>school</app-icon> <span>{{ career.title }} <div>{{ career.university_title }}</div></span>
              </router-link>
            </li></ul>
          </section>

          <section v-if="search.response.universities.length > 0">
            <div>{{ $l.universities }}</div>

            <ul><li v-for="university in search.response.universities.slice(0, 5)" :key="`university-${university.id}`">
              <router-link :to="{ name: 'university', params: { id: university.id }}">
                <app-icon>account_balance</app-icon> {{ university.title }}
              </router-link>
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
    };
  },
  watch: {
    'search.query': function() {
      clearTimeout(this.search.timeout);

      this.search.timeout = setTimeout(
        () => this.fetchLightSearchResponse(),
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
  },
  methods: {
    fetchLightSearchResponse() {
      this.search.response = null;

      let parameters = {
        text: this.search.query,
        minimize: true,
        pictures: false,
      };

      this.$API
        .search(parameters)
        .then(response => {
          put(response);
          this.search.response = response;
        })
        .catch(error => put(error));
    },
    fetchHeavySearchResponse() {
      this.$router.push({
        name: 'search',
        query: { query: this.search.query },
      });

      this.$refs.input.blur();
    },
    focus() {
      let payload = { method: this.unfocus, zIndex: 1005 };

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

      this.$a({
        targets: el,
        height: height,
        duration: 250,
        easing: 'easeInOutQuad',
        complete: () => {
          el.style.height = 'auto';

          done();
        },
      });
    },
    leave(el, done) {
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
    this.fetchLightSearchResponse();
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.search-bar
  width: 100%
  height: 48px

  @include p-relative(1010)

  .input
    $padding: .75rem

    box-sizing: border-box
    height: 100%
    padding: $padding

    @include d-flex(center)

    .icon
      color: c-gray(600)

    .icon:first-child
      margin-right: $padding

.search-bar
  $border-radius: 2px

  @include canvas($border-radius)

  .search-response
    @include border-bottom-radius($border-radius, true)

  &.opening
    @include border-top-radius($border-radius, true)

.search-response
  $gap: 1rem

  overflow-y: scroll

  max-height: 200px
  padding: 0 $gap

  cursor: default

  background-color: $c-white

  @include border-top(c-gray(100))
  @include p-absolute(1010, false, 0, false, 0)

  @include media-up(md)
    overflow-y: hidden

    max-height: unset

  section > div:first-child
    margin: $gap 0

    color: c-gray(500)

    font-size: .875em

  li
    a
      margin-bottom: $gap

      color: $c-black

      @include d-flex(center)

      color: $c-black

    .icon
      color: c-gray(400)

      @include icon(24px, $gap)

    div
      color: c-gray(500)

      font-size: $f-small
</style>
