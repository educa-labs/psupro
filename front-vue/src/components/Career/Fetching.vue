<template>
  <div class="career-container not-fetched">
    <div class="card career shimmer-background z-depth-1">
      <div class="image shimmer-background">
        <app-back-button><app-icon>arrow_back</app-icon></app-back-button>
      </div>

      <div class="card-title">
        <div>
          <div class="shimmer-background"></div>
        </div>
      </div>

      <app-tabs :fetched="false"></app-tabs>
    </div>
  </div> 
</template>

<script>
import Tabs from './../Tabs/Tabs.vue';

export default {
  components: { 'app-tabs': Tabs },
};
</script>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

$size: 75px

.career-container
  $padding: 1rem

  @include media-up(md)
    padding: 0 $padding

  & > .career
    @include media-up(md)
      width: calc(#{$breakpoint-md} - 2 * #{$padding})

      margin: $padding auto

.career-container > .career
  @include media-down(sm)
    border-radius: 0
    box-shadow: none

.career-container > .career > .image
  height: 175px

  @include media-up(sm)
    height: 300px

  @include p-relative

  & > .back-button
    color: $c-white

    @include icon(28px)
    @include p-absolute(null, 1rem, null, null, 1rem)

.career-container > .career > .card-title
  z-index: 1

  min-height: 75px

  & > div
    padding: 1rem

.career-container.not-fetched > .career > .card-title
  background-color: $c-white

  & > div
    margin-right: calc(2 * #{$size} - 1rem)

    & > div
      height: 1.5rem

      margin-bottom: .5rem

      border-radius: 2px

.shimmer-background
  animation: shimmer 2s cubic-bezier(.55, 0, .1, 1) infinite

@keyframes shimmer
  0%
    background-color: c-gray(300)
  50%
    background-color: c-gray(400)
  100%
    background-color: c-gray(300)
</style>
