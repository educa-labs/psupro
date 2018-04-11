<template>
  <div class="career-container" v-if="fetched">
    <div class="card career z-depth-1">
      <app-navigator></app-navigator>

      <section class="university"><div class="content">
        <app-expandible class="description">
          <p>{{ university.description }}</p>
        </app-expandible>
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
  </div>
</template>

<script>
import Expandible from './../Expandible.vue';

export default {
  components: {
    'app-expandible': Expandible,
  },
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      career: null,
      university: { description: '' },

      fetched: false,
    };
  },
  methods: {
    fetch() {
      this.$API.careers(this.id).then(response => {
        this.career = this.$f.formatCareer(response);

        this.$API.universities
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
};
</script>

<style lang="sass" scoped>
@import './../../assets/stylesheets/main'

.career-container
  $padding: 1rem

  @include media-up(md)
    padding: $padding

  .career
    @include media-up(md)
      width: calc(#{$breakpoint-md} - 2 * #{$padding})

.career
  @include media-down(sm)
    border-radius: 0
    box-shadow: none

  @include media-up(md)
    margin-right: auto
    margin-left: auto

  .description
    margin: 1rem
</style>
