<template>
  <ul class="tabs z-depth-1">
    <li class="tab" @click="test(0)"><a @click="$router.replace({ name: 'university' })">{{ 'Información' }}</a></li>
    <li class="tab" @click="test(1)"><a @click="$router.replace({ name: 'careers' })">{{ 'Carreras' }}</a></li>

    <li class="indicator"
      :class="{ animatedRight, animatedLeft }"
      :style="{ right: right + 'px',left: left + 'px'}"
      ref="indicator"
    ></li>
  </ul>
</template>

<script>
import anime from 'animejs';

export default {
  data() {
    return {
      active: 0,
      mounted: false,
      right: 0,
      left: 0,
      delay: 550,
      animatedRight: false,
      animatedLeft: false,
    };
  },
  computed: {
    animated() {
      return this.rightAnimated || this.leftAnimated;
    }
  },
  watch: {
    active(current, previous) {
      if (current - previous > 0) {
        this.animatedRight = true;
        this.right = this.getRight();

        setTimeout(() => {
          this.animatedLeft = true;
          this.left = this.getLeft();
        }, this.delay);
      } else if (current - previous < 0) {
        this.animatedLeft = true;
        this.left = this.getLeft();

        setTimeout(() => {
          this.animatedRight = true;
          this.right = this.getRight();
        }, this.delay);
      }
    },
  },
  methods: {
    getRight() {
      let tabs = Array.from(this.$el.children).filter(li => {
        return li.className === 'tab';
      });
      let rightTabs = tabs.slice(this.active + 1, tabs.length);

      let right = rightTabs.reduce((before, current) => {
        return before + current.offsetWidth;
      }, 0);

      return right;
    },
    getLeft() {
      let tabs = Array.from(this.$el.children).filter(li => {
        return li.className === 'tab';
      });
      let leftTabs = tabs.slice(0, this.active);

      let left = leftTabs.reduce((before, current) => {
        return before + current.offsetWidth;
      }, 0);

      return left;
    },
    setRight() {
      this.right = this.getRight();
    },
    setLeft() {
      this.left = this.getLeft();
    },
    test(index) {
      this.active = index;
    },
    set() {
      this.setRight();
      this.setLeft();
    },
    jsAnimateRight() {
      console.log(anime);
    },
  },
  mounted() {
    this.jsAnimateRight();
    this.mounted = true;
    this.set();
    this.$refs.indicator.addEventListener('transitionend', (event) => {
      if (event.propertyName === 'right') {
        console.log('right', event)
        this.animatedRight = false;        
      } else if (event.propertyName === 'left') {
        console.log('left', event)
        this.animatedLeft = false;        
      }

    });
    window.addEventListener('resize', this.set);
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

  .indicator
    will-change: right, left

  .indicator.animatedRight
    transition: right .25s ease-in-out

  .indicator.animatedLeft
    transition: left .25s ease-in-out
</style>
