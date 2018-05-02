<template>
  <div class="search">
    <app-navigator :buttons="{ back: false }" v-if="['xs', 'sm'].includes($mq)"></app-navigator>

    <app-hero class="closed" v-if="['xs', 'sm'].includes($mq)"></app-hero>

    <section class="results" :style="{ 'padding-bottom': `${filterHeight}px` }">
      <template v-if="!emptySearchResponse">
        <h5 class="title">{{ $l.cSearch.results }}</h5>

        <router-link v-for="(card, index) in response" :key="`card-${index}`"
          :to="{ name: card.name, params: card.params}"
        >
          <component :is="card.component" v-bind="card.props"></component>
        </router-link>

        <app-spinner v-if="fetching"></app-spinner>
      </template>

      <div class="empty" v-else>{{ $l.empty }}</div>
    </section>

    <app-filter :height="filterHeight"></app-filter>
  </div>
</template>

<script>
import CareerCard from './CareerCard.vue';
import Filter from './Filter.vue';
import UniversityCard from './UniversityCard.vue';

export default {
  components: {
    'app-career-card': CareerCard,
    'app-filter': Filter,
    'app-university-card': UniversityCard,
  },
  data() {
    return {
      response: [],
      page: 0,
      pageSize: 5,

      fetching: false,
      onLastPage: false,

      filterHeight: 42,
    };
  },
  computed: {
    emptySearchResponse() {
      return !this.fetching && this.response.length === 0;
    },
  },
  watch: {
    $route(to, from) {
      if (to.name === 'search') this.fetch();
    },
  },
  methods: {
    fetch(query, page) {
      this.fetching = true;

      this.$store
        .dispatch('fetchSearchResponse', {
          query,
          page,
          page_size: this.pageSize,
        })
        .then(response => {
          if (
            response.careers.length === 0 &&
            response.universities.length === 0
          ) {
            this.fetching = false;
            this.onLastPage = true;
          } else {
            this.response.push(
              ...response.careers.map(career => {
                return {
                  name: 'career',
                  params: { id: career.id },
                  component: 'app-career-card',
                  props: { career },
                };
              })
            );

            this.response.push(
              ...response.universities.map(university => {
                return {
                  name: 'university',
                  params: { id: university.id },
                  component: 'app-university-card',
                  props: { university },
                };
              })
            );

            this.page = page;

            this.fetching = false;
          }
        });
    },
    fetchDefaultPage() {
      this.fetch(this.$route.query.query, 0);
    },
    fetchNextPage() {
      this.fetch(this.$route.query.query, this.page + 1);
    },
    getOffsetHeight() {
      let heroOffsetHeight = ['xs', 'sm'].includes(this.$mq) ? 0 : 80;

      return this.$el.offsetHeight + heroOffsetHeight;
    },
  },
  created() {
    this.fetchDefaultPage();

    window.onscroll = () => {
      if (!this.onLastPage) {
        let windowBottomOffset = window.innerHeight + window.scrollY;

        if (windowBottomOffset === this.getOffsetHeight()) {
          this.fetchNextPage();
        }
      }
    };
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.search > .navigator
  @include media-down(sm)
    padding-bottom: 0

  @include p-relative
    
.search
  .career-card, .university-card
    margin: 1rem
    
    @include media-up(md)
      margin-right: 0
      margin-left: 0

.search > .results
  $padding: 1rem

  @include canvas

  @include media-up(md)
    width: calc(#{$breakpoint-md} - 2 * #{$padding})
    margin: $padding auto

.search > .results > .title
  @include media-up(md)
    border-radius: 3px

.search > .results > .empty
  transform: translate(-50%, -50%)

  @include p-absolute(unset, 50%, unset, unset, 50%)
</style>
