<template>
  <div id="home">
    <app-trending></app-trending>

    <app-news></app-news>
  </div>
</template>

<script>
import News from './News.vue';
import Trending from './Trending.vue';

export default {
  components: {
    'app-news': News,
    'app-trending': Trending,
  },
};
</script>

<style lang="sass" scoped>
</style>
