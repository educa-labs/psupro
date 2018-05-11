<template>
  <div class="tabs-container not-fetched">
    <ul class="tabs z-depth-1"></ul>
  </div>
</template>

<script>
export default {};
</script>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

.tabs-container.not-fetched > .tabs
  height: 48px

  background-color: $c-white
</style>
