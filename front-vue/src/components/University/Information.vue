<template>
  <div class="information" v-if="fetched">
    <section class="university"><div class="content">
      <div class="description">
        <p ref="description">{{ university.description }}</p>

        <app-icon>chevron_right</app-icon>
      </div>
    </div></section>

    <section class="row">
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
    </section>

    <section class="campus">
      <h5 class="title">{{ $l.cUniversity.campus }}</h5>

      <div class="content">
        <div v-for="_campus in campus" :key="`campus-${_campus.id}`">
          <app-icon>place</app-icon>

          <div>{{ _campus.title }} <div class="address">{{ _campus.address }}</div></div>
        </div>
      </div>
    </section>
  </div>

  <app-spinner v-else></app-spinner>
</template>

<script>
import Ellipsis from 'ellipsis.js';

let ellipsis = Ellipsis({ lines: 3 });

export default {
  props: {
    id: { type: Number, required: true },
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
  updated() {
    if (this.fetched) ellipsis.add(this.$refs.description);
  },
};
</script>

<style lang="sass" scoped>
.information
  margin: -1rem

  section
    color: #7A7A7A

  section.university
    .description
      display: flex
      align-items: center

      padding: 1rem

      border-bottom: 1px solid #F5F5F5
    
    .row
      padding-top: .25rem
      padding-bottom: .25rem

  section.campus .content > div
    display: flex
    align-items: center

    padding: 1.25rem

    color: #000000

    border-bottom: 1px solid #F5F5F5

    .icon
      margin-right: 1.25rem

      color: #00A2EC
    
    .address
      color: #7A7A7A

      font-size: .8em
</style>
