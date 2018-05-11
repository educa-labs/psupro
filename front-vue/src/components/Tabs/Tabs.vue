<template>
  <div class="tabs-container" v-if="fetched">
    <ul class="tabs z-depth-1" ref="tabs">
      <li v-for="(route, index) in routes" :key="`tab-${index}`"
        class="tab" :class="{ active: active === index }"
        @click="active = index"
      >
        <span>{{ route.tab }}</span>
      </li>

      <li class="indicator" ref="indicator"></li>
    </ul>

    <div class="tabs-content" ref="content">
      <transition :name="transition" @beforeEnter="setContentHeight">
        <keep-alive><router-view class="child-view"></router-view></keep-alive>
      </transition>
    </div>
  </div>
  
  <app-tabs-fetching v-else></app-tabs-fetching>
</template>

<script>
import TabsFetching from './TabsFetching.vue';

export default {
  components: {
    'app-tabs-fetching': TabsFetching,
  },
  props: {
    routes: { type: Array },
    transition: { type: String },

    fetched: { type: Boolean, default: true },
  },
  data() {
    return {
      active: 0,

      tabs: null,

      delay: 150,
      duration: 350,
      gap: 25,
    };
  },
  watch: {
    active(current, previous) {
      this.$router.replace({ name: this.routes[current].name });

      if (current - previous > 0) this.animateIndicatorToRight();
      else if (current - previous < 0) this.animateIndicatorToLeft();
    },
  },
  methods: {
    get(property) {
      let tabs = null;

      if (property === 'right')
        tabs = this.tabs.slice(this.active + 1, this.tabs.length);
      else if (property === 'left') tabs = this.tabs.slice(0, this.active);

      return (
        tabs.reduce((before, current) => {
          return before + current.offsetWidth;
        }, 0) + this.gap
      );
    },
    adjust() {
      if (this.$refs.indicator) {
        this.$refs.indicator.style.right = `${this.get('right')}px`;
        this.$refs.indicator.style.left = `${this.get('left')}px`;
      }
    },
    animateIndicator(property) {
      if (this.$refs.indicator) {
        this.$a({
          targets: this.$refs.indicator,
          duration: this.duration,
          easing: 'easeInOutQuad',
          ...(property === 'right'
            ? { right: this.get('right') }
            : { left: this.get('left') }),
        });
      }
    },
    animateIndicatorToRight() {
      this.animateIndicator('right');

      setTimeout(() => this.animateIndicator('left'), this.delay);
    },
    animateIndicatorToLeft() {
      this.animateIndicator('left');

      setTimeout(() => this.animateIndicator('right'), this.delay);
    },
    setContentHeight(el) {
      setTimeout(() => {
        this.$refs.content.style.height = `${el.offsetHeight}px`;
      }, 0);
    },
  },
  created() {
    if (this.fetched) {
      for (let [index, route] of this.routes.entries()) {
        if (route.name === this.$route.name) {
          this.active = index;

          break;
        }
      }
    }
  },
  mounted() {
    if (this.fetched) {
      this.tabs = Array.from(this.$refs.tabs.children).filter(li =>
        li.className.match(/\btab\b/)
      );

      this.adjust();

      window.addEventListener('resize', this.adjust);
    }
  },
};
</script>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

$height: 48px

.tabs
  height: $height

  background-color: lighten($c-main, 2%)

  @include d-flex
  @include p-relative(1)
  
.tab
  flex: 1

  cursor: pointer
  text-align: center
  text-transform: uppercase

  font-weight: 500

  @include text-height($height)
  @include user-select(none)

  & > span
    transition: opacity .35s

    opacity: .5

  &.active > span
    opacity: 1

.indicator
  height: 2px

  background-color: $c-white

  will-change: left, right

  @include p-absolute(null, null, null, 0)

.tabs-content
  position: relative

.tabs-content > .child-view:not(.spinner)
  transition: all .4s cubic-bezier(.55, 0, .1, 1)

  @include p-absolute(null, null, 0)

  &.slide-left-enter, &.slide-right-leave-active 
    transform: translate(100%, 0)

    opacity: 0

  &.slide-left-leave-active, &.slide-right-enter 
    transform: translate(-100%, 0)

    opacity: 0
</style>
