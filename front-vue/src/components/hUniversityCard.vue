<template>
    <div class="card university-card z-depth-1">
      <div class="cover" :style="{ 'background-image': `url(${university.image})` }">
        <div class="overlay"></div>

        <div class="title">{{ university.title }}</div>

        <app-expandible class="description" :expandible="false" :maxHeight="75" v-if="lines > 0">
          <p>{{ university.description }}</p>
        </app-expandible>
      </div>
    </div>
</template>

<script>
import Expandible from './Expandible.vue';

export default {
  components: {
    'app-expandible': Expandible,
  },
  props: {
    university: { type: Object, required: true },
    lines: { type: Number, default: 3 },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

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
      top: 0
      right: 0
      bottom: 0
      left: 0

      background: linear-gradient(transparent, #212121)

    .title
      z-index: 1

      font-size: 1.25em

    .description
      z-index: 1

      margin-top: 1rem

      font-weight: 300

    .description::after
      background: none
</style>
