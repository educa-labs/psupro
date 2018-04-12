<template>
  <div class="tabs-container">
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
</template>

<script>
export default {
  props: {
    transition: { type: String, required: true },
  },
  data() {
    return {
      active: 0,
      routes: [
        { tab: this.$l.cUniversity.information, name: 'university' },
        { tab: this.$l.cUniversity.careers, name: 'careers' },
      ],

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
      let tabs = Array.from(this.$refs.tabs.children).filter(li =>
        li.className.match(/\btab\b/)
      );

      if (property === 'right') tabs = tabs.slice(this.active + 1, tabs.length);
      else if (property === 'left') tabs = tabs.slice(0, this.active);

      return (
        tabs.reduce((before, current) => {
          return before + current.offsetWidth;
        }, 0) + this.gap
      );
    },
    adjust() {
      this.$refs.indicator.style.right = `${this.get('right')}px`;
      this.$refs.indicator.style.left = `${this.get('left')}px`;
    },
    animateIndicator(property) {
      this.$a({
        targets: this.$refs.indicator,
        duration: this.duration,
        easing: 'easeInOutQuad',
        ...(property === 'right'
          ? { right: this.get('right') }
          : { left: this.get('left') }),
      });
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
    for (let [index, route] of this.routes.entries()) {
      if (route.name === this.$route.name) {
        this.active = index;
        break;
      }
    }
  },
  mounted() {
    this.adjust();

    window.addEventListener('resize', this.adjust);
  },
};
</script>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

$height: 48px

.tabs
  height: $height

  background-color: $c-main

  @include p-relative(1)
  @include d-flex
  
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

  @include p-absolute(null, null, null, 0)

  will-change: left, right

.tabs-content
  position: relative

.tabs-content > .child-view
  transition: all .5s cubic-bezier(.55, 0, .1, 1)

  @include p-absolute(null, null, 0)

  &.slide-left-enter, &.slide-right-leave-active 
    transform: translate(100%, 0)

    opacity: 0

  &.slide-left-leave-active, &.slide-right-enter 
    transform: translate(-100%, 0)

    opacity: 0
</style>
