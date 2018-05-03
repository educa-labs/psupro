<template>
  <div class="search">
    <app-navigator :buttons="{ back: false }" v-if="['xs', 'sm'].includes($mq)"></app-navigator>

    <app-hero class="closed" v-if="['xs', 'sm'].includes($mq)"></app-hero>

    <section class="results" :style="{ 'padding-bottom': `${filterHeight}px` }">
      <template v-if="!isResponseEmpty">
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

    <app-filter @filter="setFilter" :height="filterHeight"></app-filter>
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
      filters: null,
      page: -1,
      pageSize: 10,
      onLastPage: false,

      fetching: false,

      filterHeight: 42,
    };
  },
  computed: {
    isResponseEmpty() {
      return !this.fetching && this.response.length === 0;
    },
  },
  watch: {
    $route(to, from) {
      if (to.name === 'search') {
        this.response = [];
        this.filters = null;
        this.page = 0;
        this.onLastPage = false;
        this.fetching = false;

        this.fetchNextPage();
      }
    },
  },
  methods: {
    isSearchResponseEmpty(response) {
      return (
        response.careers.length === 0 && response.universities.length === 0
      );
    },
    mergeSearchResponse(response) {
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
    },
    fetch(query, filters = {}, page) {
      return new Promise((resolve, reject) => {
        let payload = { query, filters, page, page_size: this.pageSize };

        this.$store
          .dispatch('fetchSearchResponse', payload)
          .then(response => {
            if (this.isSearchResponseEmpty(response)) {
              put('Vacío!', page, {...filters})
              this.onLastPage = true;

              if (this.page > page) this.page = page - 1;

              resolve();
            } else {
              put(response);

              this.mergeSearchResponse(response);

              resolve();
            }
          })
          .catch(error => reject(error));
      });
    },
    fetchNextPage() {
      return new Promise((resolve, reject) => {
        let nextPage = this.page + 1;

        this.fetching = true;

        this.fetch(this.$route.query.query, this.filters, nextPage)
          .then(() => {
            this.page = nextPage;

            this.fetching = false;

            resolve();
          })
          .catch(error => reject(error));
      });
    },
    refetchAll() {
      this.response = [];
      this.onLastPage = false;

      let promises = [];

      for (let i = 1; i < this.page + 1; i++)
        promises.push(this.fetch(this.$route.query.query, this.filters, i));

      this.fetching = true;

      Promise.all(promises).then(() => (this.fetching = false));
    },
    setFilter(filters) {
      this.filters = filters;

      this.refetchAll();
    },
    getOffsetHeight() {
      let heroOffsetHeight = ['xs', 'sm'].includes(this.$mq) ? 0 : 80;

      return this.$el.offsetHeight + heroOffsetHeight;
    },
  },
  created() {
    this.fetchNextPage();

    window.onscroll = () => {
      if (!this.fetching && !this.onLastPage) {
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
