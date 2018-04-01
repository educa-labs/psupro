<template>
  <div id="navigator" v-if="visible">
    <app-icon @click.native="$router.go(-1)">arrow_back</app-icon>
    
    {{ $l.cNavigator[this.$route.name] }}
  </div>
</template>

<script>
export default {
  data() {
    return {
      routesVisible: ['career', 'search'],
    };
  },
  computed: {
    visible() {
      return this.routesVisible.includes(this.$route.name);
    },
  },
};
</script>

<style lang="sass" scoped>
#navigator
  display: flex
  align-items: center

  padding: 1rem

  color: #FFFFFF

  background-color: #00A2EC

  font-size: 1.1em

  .icon
    $size: 24px

    width: $size
    height: $size

    margin-right: 1.5rem

    color: #FFFFFF

    font-size: $size
</style>
