<template>
  <section class="trending" v-if="$store.state.heavySearchResponse">
    <section class="universities">
      <template v-for="{ university, lines, delay } in universityCards">
        <transition name="fade" appear :key="`university-${university.id}`">
          <router-link 
            :to="{ name: 'university', params: { id: university.id } }"
            :style="{ 'transition-delay': `${delay}s` }"
          >
            <app-university-card
              :university="university"
              :lines="lines"
            ></app-university-card>
          </router-link>
        </transition>
      </template>
    </section>
  </section>

  <app-spinner v-else></app-spinner>
</template>

<script>
import CareerCard from './CareerCard.vue';
import hUniversityCard from './hUniversityCard.vue';

export default {
  components: {
    'app-career-card': CareerCard,
    'app-university-card': hUniversityCard,
  },
  computed: {
    universityCards() {
      let universityCards = this.$store.state.heavySearchResponse.universities
        .slice(0, 4)
        .map((university, index) => {
          return { university, delay: index / 2 };
        });

      universityCards[0].lines = 3;
      universityCards[1].lines = 2;
      universityCards[2].lines = 0;
      universityCards[3].lines = 0;

      return universityCards;
    },
  },
  watch: { $route: 'fetch' },
  methods: {
    fetch() {
      this.$store.dispatch('fetchHeavySearch', { query: '', image: true });
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.trending
  .universities
    display: grid
    min-height: 50vh

    padding: 1rem

    grid-gap: 1rem
    grid-template-rows: repeat(4, 1fr)
    grid-template-columns: 1fr

    @media (min-width: 576px)
      padding: 1rem 5%

    @media (min-width: 768px)
      padding: 1rem 10%

    @media (min-width: 992px)
      padding: 5% 10%

      grid-template-rows: repeat(2, 1fr)
      grid-template-columns: repeat(4, 1fr)
      grid-template-areas: "nth-1 nth-1 nth-1 nth-2" "nth-3 nth-3 nth-4 nth-4"

    @media (min-width: 1200px)
      grid-template-columns: 2fr repeat(2, 1fr)
      grid-template-areas: "nth-1 nth-2 nth-2" "nth-1 nth-3 nth-4"

    a
      .university-card
        height: 100%

        transition: transform .5s

        &:focus, &:hover
          transform: scale3d(1.012, 1.012, 1)

      @media (min-width: 992px)
        &:nth-child(1)
          grid-area: nth-1

        &:nth-child(2)
          grid-area: nth-2

        &:nth-child(3)
          grid-area: nth-3

        &:nth-child(4)
          grid-area: nth-4

      &.fade-enter
        opacity: 0

      &.fade-enter-active
        transition: opacity 1s ease-in-out
</style>
