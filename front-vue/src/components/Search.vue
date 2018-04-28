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

        <button @click="fetch($route.query.query, page + 1)">Ver más</button>
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

      fetching: false,

      filterHeight: 42,
    };
  },
  computed: {
    emptySearchResponse() {
      return !this.fetching && this.response.length === 0;
    },
  },
  methods: {
    fetch(query, page) {
      this.fetching = true;

      this.$store
        .dispatch('fetchSearchResponse', { query, page })
        .then(response => {
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

          this.page += 1;

          this.fetching = false;
        });
    },
  },
  created() {
    this.fetch(this.$route.query.query, this.$route.query.page);
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
