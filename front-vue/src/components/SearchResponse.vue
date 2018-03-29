<template>
  <div class="search-response" v-if="$store.state.heavySearchResponse">
    <section class="results">
      <h5 class="title">{{ 'Resultados' }}</h5>

      <template v-for="career in $store.state.heavySearchResponse.careers">
        <router-link :to="{ name: 'career', params: { id: career.id } }" :key="`career-${career.id}`">
          <app-career-card :career="career"></app-career-card>
        </router-link>
      </template>

      <template v-for="university in $store.state.heavySearchResponse.universities">
        <router-link :to="{ name: 'university', params: { id: university.id } }" :key="`university-${university.id}`">
          <app-university-card :university="university"></app-university-card>
        </router-link>
      </template>
    </section>

    <app-filter></app-filter>
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
};
</script>

<style lang="sass" scoped>
.search-response
  padding: 1em
</style>
