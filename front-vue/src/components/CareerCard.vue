<template>
  <div class="card career-card z-depth-1">
    <div class="card-content">
      <div class="image" :style="{ backgroundImage: `url(${career.image})` }"></div>

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
  },
};
</script>

<style lang="sass" scoped>
.career-card
  margin-bottom: 1rem

  .card-content
    display: flex
    align-items: center

    .information
      color: #000000

      .university-campus
        margin-top: .25rem

        color: #7A7A7A

  .image
    $gap: 1rem
    $size: 50px

    flex-shrink: 0

    width: $size
    height: $size

    margin-right: $gap

    background-position: center
    background-size: cover
</style>
