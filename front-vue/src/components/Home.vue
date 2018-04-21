<template>
  <div id="home">
    <app-hero :class="{ closed, sticky }" v-if="['xs', 'sm'].includes($mq)"></app-hero>

    <app-trending></app-trending>

    <app-news></app-news>
  </div>
</template>

<script>
import News from './News.vue';
import Trending from './Trending.vue';

export default {
  components: {
    'app-news': News,
    'app-trending': Trending,
  },
  data() {
    return {
      closed: false,
      sticky: false,
    };
  },
  mounted() {
    let breakpoints = ['xs', 'sm'];
    let threshold = 64; // height: 48px, margin-bottom: 1rem (16px)

    window.onscroll = () => {
      if (breakpoints.includes(this.$mq)) {
        if (window.pageYOffset > threshold && !this.closed) {
          this.closed = true;
          this.sticky = true;
        } else if (window.pageYOffset <= threshold && this.closed) {
          this.closed = false;
          this.sticky = false;
        }
      }
    };
  },
};
</script>

<style lang="sass" scoped>
#home
  display: grid

  grid-template-rows: auto 1fr
</style>
