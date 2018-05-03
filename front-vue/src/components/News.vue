<template>
  <section class="news" v-if="fetched">
    {{ news }}
  </section>

  <app-spinner v-else></app-spinner>
</template>

<script>
export default {
  data() {
    return {
      news: null,

      fetched: false,
    };
  },
  methods: {
    fetch() {
      this.fetched = false;

      this.$API.news.news().then(response => {
        this.news = response;

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
.news
  color: black
</style>
