<template>
  <div class="card university-card z-depth-1">
    <div class="image" :style="{ backgroundImage: `url(${university.image})` }">
      <div class="overlay"></div>

      <div class="title">{{ university.title }}</div>
    </div>

    <div class="card-content">
      <div class="description" ref="description">{{ university.description }}</div>
    </div>
  </div>
</template>

<script>
import Ellipsis from 'ellipsis.js';

let ellipsis = Ellipsis({ lines: 3 });

export default {
  props: {
    university: { type: Object, required: true },
  },
  mounted() {
    ellipsis.add(this.$refs.description);
  },
};
</script>

<style lang="sass" scoped>
.university-card
  margin-bottom: 1rem

  .image
    $height: 100px

    position: relative

    display: flex
    align-items: flex-end

    height: $height

    background-position: center
    background-size: cover

    .overlay
      position: absolute

      z-index: 0
      top: 0
      right: 0
      bottom: 0
      left: 0

      opacity: .5
      background-color: #212121

    .title
      z-index: 1

      width: 66%

      margin-bottom: 1rem
      margin-left: 1rem

      font-size: 1.25em

  .description
    color: #7A7A7A
</style>
