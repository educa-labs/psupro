<template>
  <section class="trending" v-if="$store.state.heavySearchResponse">
    <section class="universities">
      <template v-for="{ university, summaryLimit, delay } in universityCards">
        <transition name="fade" appear :key="`university-${university.id}`">
          <router-link 
            :to="{ name: 'university', params: { id: university.id } }"
            :style="{ 'transition-delay': `${delay}s` }"
          >
            <app-university-card :university="university" :summary-limit="summaryLimit"></app-university-card>
          </router-link>
        </transition>
      </template>
    </section>

    <section class="separator" style="background-image: url(https://images.pexels.com/photos/7095/people-coffee-notes-tea.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260)">
      <div class="overlay"></div>
    </section>

    <section class="news"></section>
  </section>
</template>

<script>
import CareerCard from './CareerCard.vue';
import UniversityCard from './UniversityCard2.vue';

export default {
  components: {
    'app-career-card': CareerCard,
    'app-university-card': UniversityCard,
  },
  computed: {
    universityCards() {
      let universityCards = this.$store.state.heavySearchResponse.universities
        .slice(0, 4)
        .map((university, index) => {
          return { university, delay: index / 2 };
        });

      universityCards[0].summaryLimit = 200;
      universityCards[1].summaryLimit = 50;
      universityCards[2].summaryLimit = 50;
      universityCards[3].summaryLimit = 0;

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

    padding: 5% 15%

    grid-gap: 1rem
    grid-template-rows: 200px 200px
    grid-template-columns: 2fr 1fr 1fr
    grid-template-areas: "first . ." "first last last"

    a
      .university-card
        height: 100%

        transition: transform .5s

        &:focus, &:hover
          transform: scale3d(1.012, 1.012, 1)

      &:first-child
        grid-area: first

      &:last-child
        grid-area: last

      &.fade-enter
        opacity: 0

      &.fade-enter-active
        transition: opacity 1s ease-in-out

  .separator
    position: relative

    height: 66vh

    background-position: center
    background-size: cover

    .overlay
      position: absolute

      z-index: 0
      top: 0
      right: 0
      bottom: 0
      left: 0

      opacity: .5
      background-color: #000000
</style>
