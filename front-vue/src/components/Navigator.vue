<template>
  <div class="navigator">
    <app-icon @click.native="back">arrow_back</app-icon> {{ name }}
  </div>
</template>

<script>
export default {
  data() {
    return {
      name: '',
    };
  },
  methods: {
    back() {
      this.$router.go(-1);
    },
  },
  beforeMount() {
    this.name = this.$l.cNavigator[this.$route.name];
  },
};
</script>

<style lang="sass" scoped>
.navigator
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
