<template>
  <div v-if="fetched" class="careers">
    <div class="description">{{ university.description }}</div>
  </div>
  <div v-else>Loading...</div>
</template>

<script>
export default {
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      university: null,
      fetched: false,
    };
  },
  methods: {
    fetch() {
      this.$API.universities(this.id).then(response => {
        this.university = response;
        this.fetched = true;
      });
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.careers
  color: #7A7A7A
</style>
