<template>
    <div class="card university-card z-depth-1">
      <div class="cover" :style="{ backgroundImage: `url(${university.image})` }">
        <div class="overlay"></div>

        <div class="title">{{ university.title }}</div>
        <div class="summary">{{ summary }}</div>
      </div>
    </div>
</template>

<script>
export default {
  props: {
    university: { type: Object, required: true },
    summaryLimit: { type: Number, default: 200 },
  },
  computed: {
    summary() {
      let description = this.university.description;

      if (description.length > this.summaryLimit)
        description = description.slice(0, this.summaryLimit);

      if (this.summaryLimit > 0) description = `${description}...`;

      return description;
    },
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

      opacity: .5
      background: linear-gradient(transparent, black)

    .title
      z-index: 1

      margin-bottom: 1em

      color: #FFFFFF

      font-size: 20px

    .summary
      z-index: 1

      color: #FFFFFF
</style>
