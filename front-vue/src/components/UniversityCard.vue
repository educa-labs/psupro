<template>
  <div class="card university-card z-depth-1">
    <div class="cover" :style="{ 'background-image': `url(${university.cover})` }">
      <div class="overlay"></div>

      <div class="title">{{ university.title }}</div>
    </div>

    <div class="card-content">
      <app-expandible class="description" :expandible="false" :maxHeight="75">
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
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.university-card
  .cover
    position: relative

    height: 100px

    @include d-flex(flex-end)

    .overlay
      background-color: c-gray(900)
      background-color: rgba(0, 0, 0, .70)

      @include p-absolute(0, 0, 0, 0, 0)

    .title
      $margin: 1rem

      z-index: 1

      width: 66%
      margin-bottom: $margin
      margin-left: $margin

      font-size: $f-large

  .description
    color: c-gray(600)
    font-size: $f-small
</style>
