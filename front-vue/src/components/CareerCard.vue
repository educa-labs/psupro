<template>
  <div class="card career-card z-depth-1" v-if="fetched">
    <div class="card-content">
      <div class="image" :style="{ backgroundImage: `url(${career.image})` }"></div>

      <div class="information">
        <div class="title">{{ career.title }}</div>
        <div class="university-campus">{{ `${career.university_name} en ${career.campu_name}` }}</div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    career: { type: Object, required: true },
  },
  computed: {
    fetched() {
      return this.career.image;
    },
  },
};
</script>

<style lang="sass" scoped>
.career-card
  margin-bottom: 1em

  .card-content
    display: flex
    align-items: center

    .information
      overflow: hidden

      .title
        margin-bottom: .25em

        color: #000000

      .university-campus
        color: #7A7A7A

  .image
    $gap: 1em
    $size: 50px

    flex-shrink: 0

    width: $size
    height: $size

    margin-right: $gap

    background-position: center
    background-size: cover
</style>
