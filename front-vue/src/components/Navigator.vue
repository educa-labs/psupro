<template>
  <div id="navigator">
    <button><i class="material-icons" @click="$router.go(-1)">arrow_back</i></button>
    
    <div class="name">{{ names[this.$route.name] }}</div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      names: {
        career: 'Carrera',
        university: 'Universidad',
      },
    };
  },
};
</script>

<style lang="sass" scoped>
#navigator
  display: flex
  align-items: center

  margin-bottom: .5em

  button
    $size: 24px

    width: $size
    height: $size

    margin-right: 1.5em
    padding: 0

    border: none
    outline: none

    background: none

    i
      color: #FFFFFF

      font-size: $size

  .name
    color: #FFFFFF

    font-size: larger
</style>
