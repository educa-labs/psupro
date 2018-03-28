<template>
  <div class="spinner">{{ $l.loading }}</div>
</template>

<style lang="sass" scoped>
.spinner
  animation: blink 3s infinite

  color: #7A7A7A

@keyframes blink
  0%
    opacity: 0
  33% 
    opacity: 1
  100%
    opacity: 0
</style>
