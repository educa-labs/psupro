<template>
  <div class="information" v-if="fetched">
    <section class="university"><div class="content">
      <app-expandible class="description">
        <p>{{ university.description }}</p>
      </app-expandible>
    </div></section>

    <section>
      <h5 class="title">{{ $l.cUniversity.information }}</h5>

      <div class="row">
        <div class="col-xs-12 col-sm-6">
          <table><tbody>
            <tr v-for="(value, key) in university.first" :key="key">
              <td class="key">{{ value.key }}</td>
              <td class="value">{{ value.value }}</td>
            </tr>
          </tbody></table>
        </div>

        <div class="col-xs-12 col-sm-6">
          <table><tbody>
            <tr v-for="(value, key) in university.second" :key="key">
              <td class="key">{{ value.key }}</td>
              <td class="value">{{ value.value }}</td>
            </tr>
          </tbody></table>
        </div>
      </div>
    </section>

    <section class="campus">
      <h5 class="title">{{ $l.cUniversity.campus }}</h5>

      <div class="content">
        <app-campus v-for="_campus in campus" :key="`campus-${_campus.id}`"
          :campus="_campus"
        ></app-campus>
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
      campus: null,
      university: null,

      fetched: false,
    };
  },
  methods: {
    fetch() {
      return new Promise(resolve => {
        this.$API.universities.universities(this.id).then(response => {
          this.university = this.$f.formatUniversity(response);

          this.$API.universities.campus(this.university.id).then(response => {
            this.campus = response;

            this.fetched = true;

            resolve();
          });
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
  section
    color: c-gray(600)

  section.university
    .description
      margin: 1rem
      font-weight: 300
      color: c-gray(900)
      color: $c-black
    
    .row
      padding-top: .25rem
      padding-bottom: .25rem

  section.campus > .content > .campus
    &:focus, &:hover
      background-color: c-gray(100)
</style>
