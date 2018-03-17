<template>
  <div>
    <app-search-results></app-search-results>
  </div>
</template>

<script>
import SearchResults from './SearchResults.vue';

export default {
  components: {
    'app-search-results': SearchResults,
  },
};
</script>

<style lang="sass" scoped>
</style>
