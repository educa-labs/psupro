<template>
  <i class="material-icons icon"><slot></slot></i>
</template>

<script>
export default {};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.icon
  cursor: default

  &.button
    cursor: pointer
</style>
