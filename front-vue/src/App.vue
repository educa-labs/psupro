<template>
  <div id="app">
    <transition name="fade">
      <div class="overlay" :style="{ 'z-index': $store.state.overlay.zIndex }"
        @click="$store.state.overlay.handleClick"
        v-if="$store.state.overlay.show"
      ></div>
    </transition>

    <header :class="{ sticky }" ref="header">
      <app-hero ref="hero"></app-hero>
    </header>

    <main ref="main">
      <app-navigator></app-navigator>

      <router-view></router-view>
    </main>

    <footer ref="footer"></footer>
  </div>
</template>

<script>
import Hero from './components/Hero.vue';
import Navigator from './components/Navigator.vue';

export default {
  components: {
    'app-hero': Hero,
    'app-navigator': Navigator,
  },
  data() {
    return {
      sticky: false,
    };
  },
  mounted() {
    if (this.$refs.hero) {
      let logo = this.$refs.hero.$refs.logo,
        sticky = logo.offsetHeight + 16; // margin-bottom: 1rem

      window.onscroll = () => {
        if (window.pageYOffset >= sticky) {
          logo.style.display = 'none';
          this.$refs.header.classList.add('sticky');
        } else {
          logo.style.display = 'unset';
          this.$refs.header.classList.remove('sticky');
        }
      };
    }
  },
};
</script>

<style lang="sass" scoped>
#app
  $duration: .25s
  $opacity: .66

  position: relative

  .overlay
    position: absolute
    top: 0
    right: 0
    bottom: 0
    left: 0

    opacity: $opacity
    background-color: #000000
  
    &.fade-enter
      opacity: 0

    &.fade-enter-active
      transition: all $duration ease

    &.fade-leave-active
      transition: all $duration ease

    &.fade-leave-to
      opacity: 0
  
  header.sticky
    position: fixed
    z-index: 1030
    top: 0
    right: 0
    left: 0

    & + main
      padding-top: 146px
</style>
