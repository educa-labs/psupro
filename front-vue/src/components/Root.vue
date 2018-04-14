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
          <keep-alive><router-view class="child-view"></router-view></keep-alive>
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
    if (to.name === 'home' && ['university', 'careers'].includes(from.name))
      this.transition = 'slide-right';
    else if (to.name === 'university' && from.name === 'home')
      this.transition = 'appear-top';
    else if (to.name === 'university' && from.name === 'career')
      this.transition = 'slide-right';
    else if (to.name === 'careers' && from.name === 'career')
      this.transition = 'slide-right';
    else if (to.name === 'career' && from.name === 'careers')
      this.transition = 'slide-left';

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
  min-height: 100%

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

<style lang="sass">
@import './../assets/stylesheets/main'

#root > main > .content > .child-view > .spinner
  transform: translate(-50%, -50%)

  @include p-absolute(null, 50%, unset, unset, 50%)
</style>
