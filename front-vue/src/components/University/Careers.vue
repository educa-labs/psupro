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
    id: { type: Number, required: true },
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
        this.$API.universities.careers(this.id).then(response => {
          this.careers = response;

          this.fetched = true;

          resolve();
        });
      });
    },
  },
};
</script>

<style lang="sass" scoped>
</style>
