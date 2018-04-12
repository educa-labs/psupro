<template>
  <div id="root">
    <transition name="fade">
      <app-overlay></app-overlay>
    </transition>

    <main ref="main">
      <mq-layout mq="md+">
        <app-hero :class="{ closed: $route.name !== 'home' }"></app-hero>
      </mq-layout>

      <div class="content">
        <transition :name="transition">
          <router-view class="child-view"></router-view>
        </transition>
      </div>
    </main>
  </div>
</template>

<script>
import Overlay from './Overlay.vue';

export default {
  components: {
    'app-overlay': Overlay,
  },
  data() {
    return {
      transition: 'slide-right',
    };
  },
  beforeRouteUpdate(to, from, next) {
    if (to.name === 'university' && from.name === 'home') {
      this.transition = 'appear-top';
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
@import './../assets/stylesheets/main'

#root
  position: relative

#root > .overlay
  &.fade-enter, &.fade-leave-to
    opacity: 0

  &.fade-enter-active, &.fade-leave-active
    transition: opacity 1s

#root > main
  display: grid

  min-height: 100vh

  grid-template-rows: 1fr

  @include media-up(md)
    grid-template-rows: auto 1fr

#root > main > .content
  position: relative

#root > main > .content > .child-view
  transition: all .4s cubic-bezier(.55, 0, .1, 1)

  @include p-absolute(null, null, 0, null, 0)

  &.slide-left-enter, &.slide-right-leave-active 
    transform: translate(100%, 0)

    opacity: 0

  &.slide-left-leave-active, &.slide-right-enter 
    transform: translate(-100%, 0)

    opacity: 0
  
  &.appear-top-enter
    transform: translateY(150px)

    opacity: 0

  &.appear-top-leave-active
    opacity: 0
</style>
