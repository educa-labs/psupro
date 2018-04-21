<template>
  <div class="hero z-depth-1">
    <div class="logo z-depth-2"></div>

    <app-search-bar></app-search-bar>
  </div>
</template>

<script>
import SearchBar from './SearchBar.vue';

export default {
  components: {
    'app-search-bar': SearchBar,
  },
};
</script>

<style lang="sass" scoped>
.hero
  $pattern: "data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='296' height='296' viewBox='0 0 800 800'%3E%3Cg fill='none' stroke='%23fafafa' stroke-width='1'%3E%3Cpath d='M769 229L1037 260.9M927 880L731 737 520 660 309 538 40 599 295 764 126.5 879.5 40 599-197 493 102 382-31 229 126.5 79.5-69-63'/%3E%3Cpath d='M-31 229L237 261 390 382 603 493 308.5 537.5 101.5 381.5M370 905L295 764'/%3E%3Cpath d='M520 660L578 842 731 737 840 599 603 493 520 660 295 764 309 538 390 382 539 269 769 229 577.5 41.5 370 105 295 -36 126.5 79.5 237 261 102 382 40 599 -69 737 127 880'/%3E%3Cpath d='M520-140L578.5 42.5 731-63M603 493L539 269 237 261 370 105M902 382L539 269M390 382L102 382'/%3E%3Cpath d='M-222 42L126.5 79.5 370 105 539 269 577.5 41.5 927 80 769 229 902 382 603 493 731 737M295-36L577.5 41.5M578 842L295 764M40-201L127 80M102 382L-261 269'/%3E%3C/g%3E%3Cg fill='%23ffffff'%3E%3Ccircle cx='769' cy='229' r='5'/%3E%3Ccircle cx='539' cy='269' r='5'/%3E%3Ccircle cx='603' cy='493' r='5'/%3E%3Ccircle cx='731' cy='737' r='5'/%3E%3Ccircle cx='520' cy='660' r='5'/%3E%3Ccircle cx='309' cy='538' r='5'/%3E%3Ccircle cx='295' cy='764' r='5'/%3E%3Ccircle cx='40' cy='599' r='5'/%3E%3Ccircle cx='102' cy='382' r='5'/%3E%3Ccircle cx='127' cy='80' r='5'/%3E%3Ccircle cx='370' cy='105' r='5'/%3E%3Ccircle cx='578' cy='42' r='5'/%3E%3Ccircle cx='237' cy='261' r='5'/%3E%3Ccircle cx='390' cy='382' r='5'/%3E%3C/g%3E%3C/svg%3E"

  display: flex
  align-items: center
  flex-direction: column
  justify-content: center

  padding: 1rem

  background-color: #00A2EC

  @media (min-width: 768px)
    min-height: 50%

    // background-image: url($pattern)

.hero > .logo
  width: 150px
  height: 50px

  margin-bottom: 1rem

  border-radius: 2px
  background-color: #FFFFFF

.hero > .search-bar
  @media (min-width: 768px)
    max-width: 768px

.hero.closed
  min-height: unset

.hero.closed > .logo
  display: none

.hero.sticky
  position: fixed
  z-index: 1030
  top: 0
  right: 0
  left: 0
</style>

<style lang="sass">
.hero.sticky + *
  margin-top: 146px !important
</style>
