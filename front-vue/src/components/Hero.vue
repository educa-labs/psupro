<template>
  <div id="hero">
    <div class="logo z-depth-1"></div>

    <app-search-form></app-search-form>

    <i class="material-icons">keyboard_arrow_down</i>
  </div>
</template>

<script>
import SearchForm from './SearchForm.vue';

export default {
  components: {
    'app-search-form': SearchForm,
  },
};
</script>

<style lang="sass" scoped>
#hero
  display: flex
  align-items: center
  flex-direction: column
  justify-content: space-around

  width: 100%
  height: 100vh

  background-color: #00A2EC
  background-image: url("data:image/svg+xml,%3Csvg width='60' height='60' viewBox='0 0 60 60' xmlns='http://www.w3.org/2000/svg'%3E%3Cg fill='none' fill-rule='evenodd'%3E%3Cg fill='%23ffffff' fill-opacity='0.19'%3E%3Cpath d='M36 34v-4h-2v4h-4v2h4v4h2v-4h4v-2h-4zm0-30V0h-2v4h-4v2h4v4h2V6h4V4h-4zM6 34v-4H4v4H0v2h4v4h2v-4h4v-2H6zM6 4V0H4v4H0v2h4v4h2V6h4V4H6z'/%3E%3C/g%3E%3C/g%3E%3C/svg%3E")

  .logo
    width: 300px
    height: 50px

    border-radius: 2px
    background-color: #F5F5F5

  & > form // SearchForm
    width: 85%
  
  & > i
    width: 96px
    height: 96px

    color: #F5F5F5

    font-size: 96px
</style>
