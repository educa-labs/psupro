<template>
  <div class="university-container not-fetched">
    <div class="card university shimmer-background z-depth-1">
      <div class="image shimmer-background">
        <app-back-button><app-icon>arrow_back</app-icon></app-back-button>

        <div class="profile shimmer-background z-depth-2"></div>
      </div>

      <div class="card-title">
        <div>
          <div class="shimmer-background"></div>
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

  @include p-relative

  & > .back-button
    color: $c-white

    @include icon(28px)
    @include p-absolute(null, 1rem, null, null, 1rem)

  & > .profile
    @include circle($size) 
    @include d-flex(center, center)
    @include p-absolute(2, unset, #{$size / 2}, -#{$size / 2}, unset)

.university-container > .university > .card-title
  z-index: 1

  min-height: 75px

  & > div
    padding: 1rem

.university-container.not-fetched > .university > .card-title
  background-color: $c-white

  & > div
    margin-right: calc(2 * #{$size} - 1rem)

    & > div
      border-radius: 2px

    & > div:first-child
      height: 1rem

      margin-bottom: .5rem

    & > div:last-child
      height: 1.1rem

      margin-bottom: 0

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
