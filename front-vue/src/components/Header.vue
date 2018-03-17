<template>
  <div id="header">
    <app-navigator v-if="!home"></app-navigator>

    <img src="./../assets/images/logo.svg" class="logo" v-if="home" ref="image">

    <slot></slot>
  </div>
</template>

<script>
import Navigator from './Navigator.vue';

export default {
  components: { 'app-navigator': Navigator },
  computed: {
    home() {
      return this.$route.name === 'home';
    },
  },
};
</script>

<style lang="sass" scoped>
#header
  position: fixed
  z-index: 100000
  right: 0
  left: 0

  display: flex
  flex-direction: column
  justify-content: space-between

  padding: 1em

  background-color: rgb(0, 162, 236)

  .logo
    height: 50px
</style>
