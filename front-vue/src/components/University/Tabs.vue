<template>
  <div>
    <ul class="tabs z-depth-1" ref="tabs">
      <li class="tab" :class="{ active: active === 0 }" @click="active = 0">
        <span>{{ $l.cUniversity.information }}</span>
      </li>
      <li class="tab" :class="{ active: active === 1 }" @click="active = 1">
        <span>{{ $l.cUniversity.careers }}</span>
      </li>

      <li class="indicator" ref="indicator"></li>
    </ul>

    <div class="tabs-content" :class="{ animated: active !== previous }" ref="content">
      <app-information :id="id" v-show="active === 0 || previous === 0"></app-information>
      <app-careers     :id="id" v-show="active === 1 || previous === 1"></app-careers>
    </div>
  </div>
</template>

<script>
import Careers from './Careers.vue';
import Information from './Information.vue';

export default {
  components: {
    'app-careers': Careers,
    'app-information': Information,
  },
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      active: 0,
      tabs: null,
      previous: 0,

      delay: 150,
      duration: 350,
      gap: 25,
    };
  },
  watch: {
    active(current, previous) {
      let animation = null;
      let enteringComponent = this.$children[current];

      if (current - previous > 0) animation = this.animateLeftToRight;
      else if (current - previous < 0) animation = this.animateRightToLeft;

      this.previous = previous;

      if (!enteringComponent.fetched)
        enteringComponent.fetch().then(() =>
          animation(() => {
            this.previous = current;
          })
        );
      else animation(() => (this.previous = current));
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
    animateLeftToRight(callback = () => {}) {
      this.animateIndicator('right');

      this.$a({
        targets: this.$refs.content,
        duration: this.duration,
        easing: 'easeInOutQuad',
        translateX: '-100%',
        complete: () => {
          callback();

          setTimeout(() => {
            this.$refs.content.style.transform = null;
          }, 0);
        },
      });

      setTimeout(() => this.animateIndicator('left'), this.delay);
    },
    animateRightToLeft(callback = () => {}) {
      this.$refs.content.style.transform = 'translateX(-100%)';

      this.animateIndicator('left');

      this.$a({
        targets: this.$refs.content,
        duration: this.duration,
        easing: 'easeInOutQuad',
        translateX: '0',
        complete: () => {
          callback();

          setTimeout(() => {
            this.$refs.content.style.transform = null;
          }, 0);
        },
      });

      setTimeout(() => this.animateIndicator('right'), this.delay);
    },
    adjust() {
      this.$refs.indicator.style.right = `${this.get('right')}px`;
      this.$refs.indicator.style.left = `${this.get('left')}px`;
    },
  },
  mounted() {
    this.tabs = Array.from(this.$refs.tabs.children).filter(li =>
      li.className.match(/\btab\b/)
    );

    window.addEventListener('resize', this.adjust);

    this.adjust();

    this.$children[this.active].fetch();
  },
};
</script>

<style lang="sass" scoped>
.tabs
  position: relative
  z-index: 1

  display: flex

  height: 48px

  background-color: #00ABF1
  
.tab
  flex: 1

  height: 48px

  text-align: center

  text-transform: uppercase

  line-height: 48px

  & > span
    transition: opacity .35s

    opacity: .5

  &.active > span
    opacity: 1

.indicator 
  position: absolute
  bottom: 0

  height: 2px

  background-color: #FFFFFF

  will-change: left, right

.tabs-content
  & > *
    padding: 1rem

.tabs-content.animated
  display: grid

  grid-template-columns: 100% 100%
</style>
