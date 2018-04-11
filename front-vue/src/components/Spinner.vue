<template>
  <div class="spinner">{{ $l.loading }}</div>
</template>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.spinner
  box-sizing: border-box
  height: 100%
  padding-top: 1rem
  padding-bottom: 1rem

  animation: spinner 3s infinite

  color: c-gray(600)

  @include d-flex(center, center)

@keyframes spinner
  0%
    opacity: 0
  33% 
    opacity: 1
  100%
    opacity: 0
</style>
