<template>
  <section class="trending" v-if="$store.state.searchFetched">
    <section class="careers">
      <div>{{ esCL.trending.careers }}</div>

      <router-link
        v-for="career in $store.state.search.careers"
        :key="`career-${career.id}`"
        :to="{ name: 'career', params: { id: career.id } }"
      >
        <app-career-card :career="career"></app-career-card>
      </router-link>
    </section>

    <section class="universities">
      <div>{{ esCL.trending.universities }}</div>

      <router-link 
        v-for="university in $store.state.search.universities"
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
      this.$store.dispatch('search', { search: '', image: true });
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
