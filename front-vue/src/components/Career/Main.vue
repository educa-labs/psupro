<template>
  <div class="career z-depth-1" v-if="fetched">
    <app-navigator></app-navigator>

    <section class="university"><div class="content">
      <p class="description" ref="description">{{ university.description }}</p>
    </div></section>

    <section>
      <h5 class="title">{{ $l.cCareer.weighing }}</h5>

      <div class="content">
        <table><tbody>
          <tr v-for="(value, key) in career.weighing" :key="key">
            <td class="key">{{ value.key }}</td>
            <td class="value">{{ value.value }}</td>
          </tr>

          <tr>
            <td class="key">{{ career.minScore.key }}</td>
            <td class="value">{{ career.minScore.value }}</td>
          </tr>
        </tbody></table>
      </div>
    </section>

    <section>
      <h5 class="title">{{ $l.cCareer.information }}</h5>

      <div class="content">
        <table><tbody>
          <tr v-for="(value, key) in career.information" :key="key">
            <td class="key">{{ value.key }}</td>
            <td class="value">{{ value.value }}</td>
          </tr>
        </tbody></table>
      </div>
    </section>
  </div>
</template>

<script>
import Ellipsis from 'ellipsis.js';

let ellipsis = Ellipsis({ lines: 4 });

export default {
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      career: null,
      university: {
        description: '',
      },

      fetched: false,
    };
  },
  methods: {
    fetch() {
      this.$API.careers(this.id).then(response => {
        this.career = this.$f.formatCareer(response);

        this.$API
          .universities(this.career.university_id)
          .then(response => {
            this.university.description = response.description;

            this.fetched = true;
          });
      });
    },
  },
  created() {
    this.fetch();
  },
  updated() {
    if (this.fetched) ellipsis.add(this.$refs.description);
  },
};
</script>

<style lang="sass" scoped>
.career
  @media (max-width: 575.98px)
    border-radius: 0

    box-shadow: none

  @media (min-width: 576px)
    margin: 1rem 1rem 0

  @media (min-width: 768px)
    width: 768px

    margin: 1rem auto 0

  .description
    padding: 1rem
</style>
