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
        <transition :name="transition" :mode="mode">
          <keep-alive :include="/home/"><router-view class="child-view" :key="key"></router-view></keep-alive>
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
      mode: '',
    };
  },
  computed: {
    key() {
      return get(this.$route, 'params.id');
    },
  },
  beforeRouteUpdate(to, from, next) {
    this.transition = '';
    this.mode = '';

    if (to.name === 'home') this.transition = 'leave-bottom';
    else if (from.name === 'home') this.transition = 'enter-top';
    else if (to.name === 'search') this.transition = 'slide-right';
    else if (from.name === 'search') this.transition = 'slide-left';
    else {
      this.transition = 'replace';
      this.mode = 'out-in';
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
  min-height: 100%

  transition: transform .4s cubic-bezier(.55, 0, .1, 1), opacity .4s cubic-bezier(.55, 0, .1, 1)

  @include p-absolute(null, null, 0, null, 0)

  &.slide-left-enter, &.slide-right-leave-active 
    transform: translate(100%, 0)

    opacity: 0

  &.slide-left-leave-active, &.slide-right-enter 
    transform: translate(-100%, 0)

    opacity: 0
  
  &.leave-bottom-enter
    opacity: 0

  &.leave-bottom-leave-active
    transform: translateY(150px)

    opacity: 0

  &.enter-top-enter
    transform: translateY(150px)

    opacity: 0

  &.enter-top-leave-active
    opacity: 0

  &.replace-enter
    transform: translateY(150px)

    opacity: 0

  &.replace-leave-active
    transform: translateY(100px)

    opacity: 0
</style>

<style lang="sass">
@import './../assets/stylesheets/main'

#root > main > .content > .child-view > .spinner
  transform: translate(-50%, -50%)

  @include p-absolute(unset, 50%, unset, unset, 50%)
</style>
