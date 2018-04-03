<template>
  <div id="app">
    <transition name="fade">
      <div class="overlay" :style="{ 'z-index': $store.state.overlay.zIndex }"
        @click="$store.state.overlay.handleClick"
        v-if="$store.state.overlay.show"
      ></div>
    </transition>

    <header :class="{ sticky: $store.state.header.sticky }" ref="header">
      <app-hero></app-hero>
    </header>

    <main ref="main">
      <transition :name="transition">
        <keep-alive><router-view class="child-view"></router-view></keep-alive>
      </transition>
    </main>

    <footer ref="footer"></footer>
  </div>
</template>

<script>
import Hero from './components/Hero.vue';

export default {
  components: {
    'app-hero': Hero,
  },
  data() {
    return {
      transition: 'slide-right',
    };
  },
  watch: {
    $route: (to, from) => {
      const toDepth = to.path.split('/').length;
      const fromDepth = from.path.split('/').length;

      this.transition = toDepth < fromDepth ? 'slide-right' : 'slide-left';

      console.log(this.transition);
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

  header.sticky + main
    padding-top: 146px

  main
    position: relative

.child-view
  position: absolute

  transition: transform 1s cubic-bezier(.55, 0, .1, 1), opacity 1s cubic-bezier(.55, 0, .1, 1)

.slide-left-enter, .slide-right-leave-active 
  transform: translate(100%, 0)

  opacity: 0

.slide-left-leave-active, .slide-right-enter 
  transform: translate(-100%, 0)

  opacity: 0
</style>
