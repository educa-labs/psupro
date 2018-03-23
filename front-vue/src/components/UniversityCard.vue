<template>
  <div class="card university-card z-depth-1" v-if="fetched">
    <div class="image" :style="{ backgroundImage: `url(${university.image})` }">
      <div class="overlay"></div>

      <div class="title">{{ university.title }}</div>
    </div>

    <div class="card-content">
      <div class="summary">{{ summary }}</div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    university: { type: Object, required: true },
  },
  computed: {
    fetched() {
      // return this.university.image;

      return true;
    },
    summary() {
      let description = this.university.description,
        maxLength = 100;

      if (description.length > maxLength)
        return `${description.slice(0, maxLength)}...`;

      return description;
    },
  },
};
</script>

<style lang="sass" scoped>
.university-card
  margin-bottom: 1em

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
      background-color: #000000

    .title
      z-index: 1
      font-size: large

      margin-bottom: 1em
      margin-left: 1em
      width: 50%

      color: #FFFFFF

  .summary
    color: #7A7A7A
</style>
