<template>
    <div class="card university-card z-depth-1">
      <div class="cover" :style="{ backgroundImage: `url(${university.image})` }">
        <div class="overlay"></div>

        <div class="title">{{ university.title }}</div>
        <div class="description" ref="description" v-if="lines > 0">{{ university.description }}</div>
      </div>
    </div>
</template>

<script>
import Ellipsis from 'ellipsis.js';

export default {
  props: {
    university: { type: Object, required: true },
    lines: { type: Number, default: 3 },
  },
  data() {
    return {
      ellipsis: Ellipsis({ lines: this.lines + 1 }),
    };
  },
  mounted() {
    this.ellipsis.add(this.$refs.description);
  },
};
</script>

<style lang="sass" scoped>
.university-card
  .cover
    position: relative

    display: flex
    align-items: flex-start
    flex-direction: column
    justify-content: flex-end

    box-sizing: border-box

    height: 100%

    padding: 1rem

    background-position: center
    background-size: cover

    .overlay
      position: absolute

      z-index: 0
      top: 50%
      right: 0
      bottom: 0
      left: 0

      opacity: .75
      background: linear-gradient(transparent, #000000)

    .title
      z-index: 1

      color: #FFFFFF

      font-size: 20px

    .description
      z-index: 1

      color: #FFFFFF
      margin-top: 1rem

      font-weight: 300
</style>
