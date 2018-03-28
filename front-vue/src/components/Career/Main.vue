<template>
  <div class="career">
    <section class="weighing">
      <h5 class="title">Ponderación</h5>

      <div class="content">
        <table>
          <tbody>
            <tr v-for="(value, key) in career.weighing" :key="key">
              <td>{{ value.key }}</td>
              <td>{{ value.value }}</td>
            </tr>

            <tr>
              <td>{{ career.minScore.key }}</td>
              <td>{{ career.minScore.value }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>

    <section class="information">
      <h5 class="title">Información</h5>

      <div class="content">
        <table>
          <tbody>
            <tr v-for="(value, key) in career.information" :key="key">
              <td>{{ value.key }}</td>
              <td>{{ value.value }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </section>
  </div>
</template>

<script>
export default {
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      career: null,
    };
  },
  watch: { $route: 'fetch' },
  methods: {
    fetch() {
      this.$API.careers(this.id).then(response => {
        this.career = response;
      });
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.career
  min-height: 100vh

  background-color: rgb(245, 245, 245)

  section
    .title
      padding: 1em 1rem .5em

    .content
      min-height: 100px

      background-color: #ffffff

      table
        width: 100%

        td
          padding: .75em 1em
        
        td:first-child
          width: 60%
</style>
