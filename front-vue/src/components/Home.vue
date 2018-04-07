<template>
  <div id="home">
    <app-hero :class="{ closed, sticky }"></app-hero>

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
    let threshold = 66; // height: 50px, margin-bottom: 1rem (16px)

    window.onscroll = () => {
      if (this.$mq === 'xs') {
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
</style>
