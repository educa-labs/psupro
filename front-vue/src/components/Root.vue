<template>
  <div id="root">
    <transition name="fade">
      <div class="overlay" :style="{ 'z-index': $store.state.overlay.zIndex }"
        @click="$store.state.overlay.handleClick"
        v-if="$store.state.overlay.show"
      ></div>
    </transition>

    <main ref="main">
      <mq-layout mq="md+">
        <app-hero :class="{ closed: $route.name !== 'home' }"></app-hero>
      </mq-layout>

      <transition :name="transition">
        <keep-alive><router-view class="child-view"></router-view></keep-alive>
      </transition>
    </main>
  </div>
</template>

<script>

export default {
  data() {
    return {
      transition: 'slide-right',
    };
  },
  beforeRouteUpdate(to, from, next) {
    if (to.name === 'university' && from.name === 'home') {
      this.transition = 'scale-in';
    } else if (to.name === 'university' && from.name === 'career') {
      this.transition = 'slide-right';
    } else {
      const toDepth = to.path.split('/').length;
      const fromDepth = from.path.split('/').length;

      this.transition = toDepth < fromDepth ? 'slide-right' : 'slide-left';
    }

    next();
  },
};
</script>

<style lang="sass" scoped>
#root
  position: relative

#root .overlay
  $duration: .25s
  $opacity: .66

  position: fixed
  top: 0
  right: 0
  bottom: 0
  left: 0

  opacity: $opacity

  background-color: #000000

  &.fade-enter, &.fade-leave-to
    opacity: 0

  &.fade-enter-active, &.fade-leave-active
    transition: opacity $duration

#root main
  position: relative

  min-height: 100vh

#root .child-view
  position: absolute
  right: 0
  left: 0

  transition: all .5s cubic-bezier(.55, 0, .1, 1)

  &.slide-left-enter, &.slide-right-leave-active 
    transform: translate(100%, 0)

    opacity: 0

  &.slide-left-leave-active, &.slide-right-enter 
    transform: translate(-100%, 0)

    opacity: 0
  
  &.scale-in-enter
    transform: translateY(150px)

    opacity: 0
</style>
