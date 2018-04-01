<template>
  <div class="search" v-if="$store.state.heavySearchResponse">
    <section class="results" :style="{ 'padding-bottom': `${height}px` }" v-if="!emptySearchResponse">
      <h5 class="title">{{ $l.cSearch.results }}</h5>

      <router-link
        v-for="career in $store.state.heavySearchResponse.careers"
        :to="{ name: 'career', params: { id: career.id } }"
        :key="`career-${career.id}`"
      >
        <app-career-card :career="career"></app-career-card>
      </router-link>

      <router-link
        v-for="university in $store.state.heavySearchResponse.universities"
        :key="`university-${university.id}`"
        :to="{ name: 'university', params: { id: university.id } }"
      >
        <app-university-card :university="university"></app-university-card>
      </router-link>

      <app-filter :height="height"></app-filter>
    </section>

    <div class="empty" v-else>{{ $l.empty }}</div>
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
      height: 42,
    };
  },
  computed: {
    emptySearchResponse() {
      let response = this.$store.state.heavySearchResponse;

      return (
        response.universities.length === 0 && response.careers.length === 0
      );
    },
  },
};
</script>

<style lang="sass" scoped>
.search
  .career-card, .university-card
    margin: 1rem
</style>
