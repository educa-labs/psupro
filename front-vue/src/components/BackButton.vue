<template>
  <app-icon class="back-button" @click.native="back">arrow_back</app-icon>
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
