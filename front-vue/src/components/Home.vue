<template>
  <div id="home">
    <app-trending></app-trending>

    <section class="separator" style="background-image: url(https://images.pexels.com/photos/7095/people-coffee-notes-tea.jpg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260)">
      <div class="overlay"></div>
    </section>

    <section class="news"></section>
  </div>
</template>

<script>
import Trending from './Trending.vue';

export default {
  components: {
    'app-trending': Trending,
  },
};
</script>

<style lang="sass" scoped>
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
