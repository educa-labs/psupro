<template>
  <div class="spinner">{{ $l.loading }}</div>
</template>

<style lang="sass" scoped>
.spinner
  margin: 1rem 0

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
