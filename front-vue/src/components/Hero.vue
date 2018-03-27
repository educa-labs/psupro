<template>
  <div id="hero" :class="{ test: $store.state.test }">
    <div class="logo z-depth-2" v-if="!$store.state.test"></div>

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
#hero
  display: flex
  align-items: center
  flex-direction: column
  justify-content: center

  height: 66vh

  transition: all .25s ease

  padding-right: 20%
  padding-left: 20%

  background-color: #00A2EC
  background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.19'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")

  .logo
    width: 300px
    height: 50px
    margin-bottom: 1rem

    border-radius: 2px
    background-color: #F5F5F5

  & > form // SearchForm
    width: 85%
  
  & > i
    width: 96px
    height: 96px

    color: #F5F5F5

    font-size: 96px

#hero.test
  height: 100px
</style>
