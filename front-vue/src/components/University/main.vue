<template>
  <div class="university-container" v-if="fetched">
    <div class="card university z-depth-1">
      <div class="cover" :style="{ backgroundImage: `url(${university.cover})` }">
        <app-icon @click.native="$router.go(-1)">arrow_back</app-icon>

        <div class="profile z-depth-2"><div :style="{ backgroundImage: `url(${university.profile})` }"></div></div>
      </div>

      <div class="card-title">
        <div>{{ university.title }} <br> {{ university.initials }}</div>
      </div>

      <app-tabs :transition="transition"></app-tabs>
    </div>
  </div> 

  <app-spinner v-else></app-spinner>
</template>

<script>
import Tabs from './Tabs.vue';

export default {
  components: {
    'app-tabs': Tabs,
  },
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      university: null,

      fetched: false,

      transition: '',
    };
  },
  methods: {
    fetch() {
      this.$API.universities.universities(this.id).then(response => {
        this.university = response;

        this.$API.universities
          .universities(this.id, { params: { image: true } })
          .then(response => {
            this.university.cover = response.cover;
            this.university.profile = response.profile;

            this.fetched = true;
          });
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
    padding: $padding

  .university
    @include media-up(md)
      width: calc(#{$breakpoint-md} - 2 * #{$padding})

.university
  @include media-down(sm)
    border-radius: 0
    box-shadow: none

  @include media-up(md)
    margin-right: auto
    margin-left: auto
  
  .cover
    height: 175px

    @include p-relative
    @include background-image

    @include media-up(sm)
      height: 300px

    .icon
      @include p-absolute(null, 1rem, null, null, 1rem)

    .profile
      $size: 75px

      background-color: $c-white

      @include p-absolute(2, unset, #{$size / 2}, -#{$size / 2}, unset)
      @include d-flex(center, center)
      @include circle($size) 

      & > div
        @include size(75%)
        @include background-image

  .card-title
    z-index: 1

    min-height: 75px

    background-color: $c-main

    & > div
      width: 50%
      padding: 1rem

      font-size: $f-large
</style>
