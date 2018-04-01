<template>
  <div>
    <ul class="tabs z-depth-1">
      <li class="tab"
        :class="{ active: active === 0 }"
        @click="active = 0">
        <a @click="$router.replace({ name: 'university' })">{{ 'Información' }}</a>
      </li>

      <li class="tab"
        :class="{ active: active === 1 }"
        @click="active = 1">
        <a @click="$router.replace({ name: 'careers' })">{{ 'Carreras' }}</a>
      </li>

      <li class="indicator" ref="indicator"></li>
    </ul>

    <div class="card-content">
      <transition :name="transitionName" mode="out-in">
        <keep-alive><router-view></router-view></keep-alive>
      </transition>
    </div>
  </div>
</template>

<script>
import anime from 'animejs';

export default {
  data() {
    return {
      active: 0,
      tabs: null,

      delay: 150,
      duration: 350,
      gap: 25,

      transitionName: null,
    };
  },
  watch: {
    active(current, previous) {
      if (current - previous > 0) {
        this.transitionName = 'swipe-2';
        this.animate('right');

        setTimeout(() => {
          this.animate('left');
        }, this.delay);
      } else if (current - previous < 0) { // from right to left
        this.transitionName = 'swipe-1';
        this.animate('left');

        setTimeout(() => {
          this.animate('right');
        }, this.delay);
      }
    },
  },
  methods: {
    right() {
      let rightTabs = this.tabs.slice(this.active + 1, this.tabs.length);

      return (
        rightTabs.reduce((before, current) => {
          return before + current.offsetWidth;
        }, 0) + this.gap
      );
    },
    left() {
      let leftTabs = this.tabs.slice(0, this.active);

      return (
        leftTabs.reduce((before, current) => {
          return before + current.offsetWidth;
        }, 0) + this.gap
      );
    },
    animate(property) {
      anime({
        targets: this.$refs.indicator,
        duration: this.duration,
        easing: 'easeInOutQuad',
        ...(property === 'right'
          ? { right: this.right() }
          : { left: this.left() }),
      });
    },
    setRightLeft() {
      this.$refs.indicator.style.right = `${this.right()}px`;
      this.$refs.indicator.style.left = `${this.left()}px`;
    },
  },
  mounted() {
    this.tabs = Array.from(this.$el.children).filter(li => {
      return li.className.match(/\btab\b/);
    });

    this.setRightLeft();
    window.addEventListener('resize', this.setRightLeft);
  },
};
</script>

<style lang="sass" scoped>
.tabs
  display: flex

  padding: 0

  text-align: center

  background-color: rgb(0, 171, 241)
  
  li
    flex: 1

    a
      padding: 0

// From left to right
// se debe mostrar cuando el número está a la izquierda
.swipe-1-enter
  transform: translateX(-100%)

.swipe-1-enter-active, .swipe-1-leave-active
  transition: transform 1s

.swipe-1-leave-to
  transform: translateX(100%)

// From right to left
.swipe-2-enter
  transform: translateX(100%)

.swipe-2-enter-active, .swipe-2-leave-active
  transition: transform 1s

.swipe-2-leave-to
  transform: translateX(-100%)
</style>
