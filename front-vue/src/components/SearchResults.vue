<template>
  <div class="search-results">
    <section class="careers">
      <h5 class="title">Carreras populares</h5>

      <template v-for="career in careers">
        <router-link :to="{ name: 'career', params: { id: career.id } }" :key="career.id">
          <app-career-card :career="career"></app-career-card>
        </router-link>
      </template>
    </section>

    <section class="universities">
      <h5 class="title">Universidades populares</h5>

      <template v-for="university in universities">
        <router-link :to="{ name: 'university', params: { id: university.id } }" :key="university.id">
          <app-university-card :university="university"></app-university-card>
        </router-link>
      </template>
    </section>
  </div>
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
      careers: null,
      universities: null,
    };
  },
  watch: { $route: 'fetch' },
  methods: {
    fetchCareers() {
      this.$API.popular.careers().then(response => {
        let careers = response.body;

        careers.forEach(career => {
          career.image = null;
        });

        this.careers = careers;

        this.careers.forEach(career => {
          this.$API
            .universities(career.university_id, {
              params: { image: true },
            })
            .then(response => {
              career.image = response.profile;
            });
        });
      });
    },
    fetchUniversities() {
      this.$API.popular.universities().then(response => {
        let universities = response.body;

        universities.forEach(university => {
          university.image = null;
        });

        this.universities = universities;

        this.universities.forEach(university => {
          this.$API
            .universities(university.id, {
              params: { image: true },
            })
            .then(response => {
              university.image = response.cover;
            });
        });
      });
    },
    fetch() {
      this.fetchCareers();
      this.fetchUniversities();
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.search-results
  padding: 1em
</style>
