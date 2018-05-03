<template>
  <div class="careers" v-if="fetched">
    <router-link v-for="career in careers" :key="`career-${career.id}`"
      :to="{ name: 'career', params: { id: career.id } }"
    >
      <app-career-card :career="career"></app-career-card>
    </router-link>
  </div>

  <app-spinner v-else></app-spinner>
</template>

<script>
import CareerCard from './../CareerCard.vue';

export default {
  components: {
    'app-career-card': CareerCard,
  },
  props: {
    id: { type: Number },
  },
  data() {
    return {
      careers: null,

      fetched: false,
    };
  },
  methods: {
    fetch() {
      return new Promise(resolve => {
        let params = { image: true };

        this.$API
          .similar({ id: this.id, k: 5 })
          .then(response => {
            put(response);

            this.careers = response;

            this.fetched = true;

            resolve();
            /*
            */
          })
          .catch(error => {
            put(error);
          });

        /*
        this.$API.universities.universities(1, { params }).then(university => {
          this.university = university;

          this.$API.universities.careers(1).then(careers => {
            this.careers = careers;

            this.fetched = true;

            resolve();
          });
        });
        */
      });
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

.careers
  padding: 2rem

.careers > a > .career-card
  transition: background-color .1s

  &:focus, &:hover
    background-color: c-gray(100)

.careers > a:last-child > .career-card
  margin-bottom: 0
</style>
