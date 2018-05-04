<template>
  <div class="information" v-if="fetched">
    <section><div class="content">
      <app-expandible class="description">
        <p>{{ career.description }}</p>
      </app-expandible>
    </div></section>

    <section>
      <h5 class="title">{{ $l.cCareer.weighing }}</h5>

      <div class="content">
        <table><tbody>
          <tr v-for="(value, key) in career.weighing" :key="key">
            <td class="key">{{ value.key }}</td>
            <td class="value" :class="{ undefined: !value.value }">{{ value.value || $l.undefined }}</td>
          </tr>

          <tr>
            <td class="key">{{ career.minScore.key }}</td>
            <td class="value" :class="{ undefined: !career.minScore.value }">{{ career.minScore.value || $l.undefined }}</td>
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
            <td class="value" :class="{ undefined: !value.value }">{{ value.value || $l.undefined }}</td>
          </tr>
        </tbody></table>
      </div>
    </section>

    <section class="campus">
      <h5 class="title">{{ $l.cCareer.campus }}</h5>

      <div class="content">
        <app-campus :campus="campus"></app-campus>
      </div>
    </section>
  </div>

  <app-spinner v-else></app-spinner>
</template>

<script>
import Campus from './../Campus.vue';
import Expandible from './../Expandible.vue';

export default {
  components: {
    'app-campus': Campus,
    'app-expandible': Expandible,
  },
  props: {
    id: { type: Number },
  },
  data() {
    return {
      career: null,
      campus: null,

      fetched: false,
    };
  },
  methods: {
    fetch() {
      this.fetched = false;

      this.$API.careers(this.id).then(response => {
        this.career = this.$f.formatCareer(response);

        this.$API.campus(this.career.campus_id).then(response => {
          this.campus = response;

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

.information
  @include media-down(sm)
    border-radius: 0
    box-shadow: none

  @include media-up(md)
    margin-right: auto
    margin-left: auto

  .description
    margin: 1rem
    font-weight: 300
    color: c-gray(900)
    color: $c-black

  section.campus > .content > .campus
    &:focus, &:hover
      background-color: c-gray(100)
</style>
