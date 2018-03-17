<template>
  <div id="app">
    <app-header ref="header">
      <app-search-form></app-search-form>
    </app-header> 

    <div class="body" ref="body">
      <transition name="fade">
        <div class="overlay" v-if="$store.state.test"></div>
      </transition>

      <router-view></router-view>
    </div>
  </div>
</template>

<script>
import Header from './components/Header.vue';
import SearchForm from './components/SearchForm.vue';

export default {
  components: {
    'app-header': Header,
    'app-search-form': SearchForm,
  },
  mounted() {
    let image = this.$refs.header.$refs.image,
      height = image.clientHeight,
      maxYOffset = 100;

    // console.log(this.$refs.body.clientHeight);

    let scrollHandler = setInterval(() => {
      if (image) {
        let newHeight = -1 * height / maxYOffset * window.pageYOffset + height,
          newOpacity = -1 * window.pageYOffset / maxYOffset + 1;

        newHeight = newHeight > 0 ? newHeight : 0;
        newOpacity = newOpacity > 0 ? newOpacity : 0;

        image.style.height = `${newHeight}px`;
        image.style.opacity = newOpacity;
      }

      // let paddingTop = this.$refs.header.$el.clientHeight;
      // this.$refs.body.style.paddingTop = paddingTop;
    }, 10);
  },
};
</script>

<style lang="sass">
.body
  $duration: .2s

  position: relative

  .overlay
    position: absolute
    z-index: 1000
    top: 0
    right: 0
    bottom: 0
    left: 0

    opacity: .75
    background-color: #000000
  
  .fade-enter
    opacity: 0

  .fade-enter-active
    transition: all $duration ease

  .fade-leave-active
    transition: all $duration ease

  .fade-leave-to
    opacity: 0
</style>
