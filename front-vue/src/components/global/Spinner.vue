<template>
  <div class="spinner">{{ $l.loading }}</div>
</template>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

.spinner
  padding-top: 2rem
  padding-bottom: 2rem

  animation: spinner 3s infinite
  text-align: center

  color: c-gray(600)

@keyframes spinner
  0%
    opacity: 0
  33% 
    opacity: 1
  100%
    opacity: 0
</style>
