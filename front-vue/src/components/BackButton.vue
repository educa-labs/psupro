<template>
  <button type="button" class="back-button" @click="back">
    <slot></slot>
  </button>
</template>

<script>
export default {
  methods: {
    back() {
      this.$router.go(-1);
    },
  },
};
</script>

<style lang="sass" scoped>
</style>
