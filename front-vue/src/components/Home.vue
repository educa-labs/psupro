<template>
  <div id="home">
    <app-trending></app-trending>

    <section class="news"></section>
  </div>
</template>

<script>
/*
TODO:
  - ¿debería colocar un sombreado al hero?
  - corregir alturas
  - insipirarme
*/

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
