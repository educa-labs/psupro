<template>
  <div class="search">
    <app-navigator></app-navigator>

    <app-hero class="closed" v-if="['xs', 'sm'].includes($mq)"></app-hero>

    <section class="results" :style="{ 'padding-bottom': `${filterHeight}px` }" v-if="!$store.state.search.fetching">
      <template v-if="!emptySearchResponse">
        <h5 class="title">{{ $l.cSearch.results }}</h5>

        <router-link
          v-for="career in $store.state.search.response.careers"
          :to="{ name: 'career', params: { id: career.id } }"
          :key="`career-${career.id}`"
        >
          <app-career-card :career="career"></app-career-card>
        </router-link>

        <router-link
          v-for="university in $store.state.search.response.universities"
          :key="`university-${university.id}`"
          :to="{ name: 'university', params: { id: university.id } }"
        >
          <app-university-card :university="university"></app-university-card>
        </router-link>
      </template>

      <div class="empty" v-else>{{ $l.empty }}</div>
    </section>

    <app-spinner v-else></app-spinner>

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
      filterHeight: 42,
    };
  },
  computed: {
    emptySearchResponse() {
      let response = this.$store.state.search.response;

      return (
        response.universities.length === 0 && response.careers.length === 0
      );
    },
  },
  created() {
    if (
      !this.$store.state.search.response &&
      !this.$store.state.search.fetching
    )
      this.$store.dispatch('fetchSearchResponse', { query: '' });
  },
};
</script>

<style lang="sass" scoped>
.search
  .navigator
    position: relative

    @media (max-width: 767.98px)
      padding-bottom: 0
  
  .career-card, .university-card
    margin: 1rem
</style>
