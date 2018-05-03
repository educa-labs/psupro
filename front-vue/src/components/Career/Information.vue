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

  <app-spinner v-else></app-spinner>
</template>

<script>
import Expandible from './../Expandible.vue';

export default {
  components: {
    'app-expandible': Expandible,
  },
  props: {
    id: { type: Number },
    // career: { type: Object, required: true },
  },
  data() {
    return {
      career: null,
      // career: this.$parent.$parent.career,

      fetched: false,
    };
  },
  methods: {
    fetch() {
      this.fetched = false;

      this.$API.careers(this.id).then(response => {
        this.career = this.$f.formatCareer(response);

        put(this.career)

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
</style>
