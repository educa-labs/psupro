<template>
</template>

<script>
export default {
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      university: null,
    };
  },
  watch: { $route: 'fetch' },
  methods: {
    fetch() {
      this.$API.universities(this.id).then(response => {
        this.university = response;
      });
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
</style>
