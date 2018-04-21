<template>
  <div class="card career-card z-depth-1">
    <div class="card-content">
      <div class="image" :style="{ 'background-image': `url(${university.profile})` }"></div>

      <div class="information">
        {{ career.title }}

        <div class="university-campus">
          {{ `${career.university_name} ${$l.in} ${career.campu_name}` }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    career: { type: Object, required: true },
    university: { type: Object, required: true },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.career-card
  margin: 0 auto 1rem

.career-card > .card-content
  @include d-flex(center)

  .image
    flex-shrink: 0

    @include background-image
    @include icon(48px, 1rem)

  .information
    text-transform: uppercase

    color: $c-black

  .information > .university-campus
    margin-top: .25rem

    color: c-gray(600)

    font-size: $f-small
</style>
