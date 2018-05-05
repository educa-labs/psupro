<template>
  <div class="card career-card z-depth-1">
    <div class="card-content">
      <div class="image" :style="{ 'background-image': `url(${career.university_picture})` }"></div>

      <div class="information">
        <div class="title">
          {{ career.title }}
        </div>

        <div class="university-campus">
          {{ `${career.university_title} ${$l.in} ${career.campu_name}` }}
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    career: { type: Object, required: true },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.career-card > .card-content
  @include d-flex(center)

  .image
    flex-shrink: 0

    @include background-image
    @include icon(56px, 1rem)

  .information
    color: $c-black

  .information > .title
    display: inline-block

  .information > .university-campus
    margin-top: .25rem

    color: c-gray(600)

    font-size: $f-small
</style>
