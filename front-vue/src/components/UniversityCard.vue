<template>
  <div class="card university-card z-depth-1">
    <div class="background-image" :style="{ backgroundImage: `url(${university.image})` }">
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
@import './../assets/stylesheets/main'

.university-card
  margin-bottom: 1rem

  .background-image
    position: relative

    height: 100px

    @include d-flex(flex-end)

    .overlay
      opacity: .5
      background-color: c-gray(900)

      @include p-absolute(0, 0, 0, 0, 0)

    .title
      $margin: 1rem

      z-index: 1

      width: 66%
      margin-bottom: $margin
      margin-left: $margin

      font-size: 1.25em

  .description
    color: c-gray(600)
</style>
