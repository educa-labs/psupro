<template>
  <section class="trending" v-if="$store.state.heavySearchResponseFetched">
    <section class="careers">
      <div>{{ esCL.trending.careers }}</div>

      <router-link
        v-for="career in $store.state.heavySearchResponse.careers"
        :key="`career-${career.id}`"
        :to="{ name: 'career', params: { id: career.id } }"
      >
        <app-career-card :career="career"></app-career-card>
      </router-link>
    </section>

    <section class="universities">
      <div>{{ esCL.trending.universities }}</div>

      <router-link 
        v-for="university in $store.state.heavySearchResponse.universities"
        :key="`university-${university.id}`"
        :to="{ name: 'university', params: { id: university.id } }"
      >
        <app-university-card :university="university"></app-university-card>
      </router-link>
    </section>
  </section>
</template>

<script>
import CareerCard from './CareerCard.vue';
import UniversityCard from './UniversityCard.vue';

export default {
  components: {
    'app-career-card': CareerCard,
    'app-university-card': UniversityCard,
  },
  data() {
    return {
      esCL: {
        trending: {
          careers: 'Carreras populares',
          universities: 'Universidades populares',
        },
      },
    };
  },
  watch: { $route: 'fetch' },
  methods: {
    fetch() {
      let payload = { query: '', image: true };
      this.$store.dispatch('fetchHeavySearch', payload);
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.trending
  padding: 1em
</style>
