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

      <app-tabs :id="university.id">
        <app-tab :name="$l.cUniversity.information">
          <app-information :id="university.id"></app-information>
        </app-tab>

        <app-tab :name="$l.cUniversity.careers">
          <app-careers :id="university.id"></app-careers>
        </app-tab>
      </app-tabs>
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
    };
  },
  methods: {
    fetch() {
      this.$API.universities
        .universities(this.id)
        .then(response => {
          this.university = response;

          this.$API.universities
            .universities(this.id, { params: { image: true } })
            .then(response => {
              this.university.cover = response.cover;
              this.university.profile = response.profile;

              this.fetched = true;
            });
        })
        .catch(error => put(error));
    },
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

  &.fade-enter
    transform: scale(.1)

    opacity: 0

  &.fade-enter-active
    transition: transform 250ms, opacity 250ms

  @include media-up(md)
    padding: $padding

  .career
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
    $height: 300px

    position: relative

    height: 175px

    background-position: center
    background-size: cover

    @media (min-width: 576px)
      height: $height

    .icon
      position: absolute
      top: 1rem
      left: 1rem

    .profile
      $size: 75px

      position: absolute
      z-index: 2
      right: #{$size / 2}
      bottom: -#{$size / 2}

      display: flex
      align-items: center
      justify-content: center

      width: $size
      height: $size

      border-radius: 50%
      background-color: #FFFFFF

      & > div
        width: 75%
        height: 75%

        background-position: center
        background-size: cover

  .card-title
    $height: 75px

    z-index: 1

    min-height: $height

    background-color: #00A2EC

    & > div
      width: 50%
      padding: 1rem

      font-size: large
</style>
