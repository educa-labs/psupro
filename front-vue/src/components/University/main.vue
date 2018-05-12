<template>
  <div>
    <div class="university-container" v-if="fetched">
      <div class="card university z-depth-1">
        <div class="image" :style="{ backgroundImage: `url(${university.cover})` }">
          <div class="overlay"></div>

          <app-back-button><app-icon>arrow_back</app-icon></app-back-button>

          <div class="profile z-depth-2"><div :style="{ backgroundImage: `url(${university.profile})` }"></div></div>
        </div>

        <div class="card-title">
          <div>{{ university.title }} <div>{{ university.initials }}</div></div>
        </div>

        <app-tabs :routes="routes" :transition="transition"></app-tabs>
      </div>
    </div> 

    <app-fetching v-else></app-fetching>
  </div>
</template>

<script>
import Fetching from './Fetching.vue';
import Tabs from './../Tabs/Tabs.vue';

export default {
  components: {
    'app-fetching': Fetching,
    'app-tabs': Tabs,
  },
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      university: null,
      routes: [
        { tab: this.$l.cUniversity.information, name: 'university' },
        { tab: this.$l.cUniversity.careers, name: 'careers' },
      ],

      fetched: false,

      transition: '',
    };
  },
  methods: {
    reset() {
      this.fetched = false;

      this.transition = '';
    },
    fetch() {
      this.reset();

      let params = { image: true };

      this.$API.universities
        .universities(this.id, { params })
        .then(response => {
          this.university = response;

          this.fetched = true;
        });
    },
  },
  beforeRouteUpdate(to, from, next) {
    if (to.name === 'university' && from.name === 'careers')
      this.transition = 'slide-right';
    else if (to.name === 'careers' && from.name === 'university')
      this.transition = 'slide-left';

    next();
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

.university-container
  $padding: 1rem

  @include media-up(md)
    padding: 0 $padding

  & > .university
    @include media-up(md)
      width: calc(#{$breakpoint-md} - 2 * #{$padding})
      margin: $padding auto

.university-container > .university
  @include media-down(sm)
    border-radius: 0
    box-shadow: none

.university-container > .university > .image
  height: 175px

  @include media-up(sm)
    height: 300px

  @include background-image
  @include p-relative

  & > .overlay
    background: linear-gradient(to top, transparent, rgba(0, 0, 0, .3))

    @include p-absolute(0, 0, 0, 0 ,0)

  & > .back-button
    color: $c-white

    @include icon(28px)
    @include p-absolute(null, 1rem, null, null, 1rem)

  & > .profile
    background-color: $c-white

    $size: 75px

    @include circle($size) 
    @include d-flex(center, center)
    @include p-absolute(2, unset, #{$size / 2}, -#{$size / 2}, unset)

    & > div
      @include background-image
      @include size(66%)

.university-container > .university > .card-title
  z-index: 1

  min-height: 75px

  background-color: $c-main

  & > div
    width: 66%
    padding: 1rem

    font-size: $f-x-large
    font-weight: 500
    
    & > div
      font-size: 1.1rem
</style>
