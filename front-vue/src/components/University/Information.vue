<template>
  <div v-if="fetched" class="information">
    <div class="description">{{ university.description }}</div>

    <div class="row">
      <div class="col-xs-12 col-sm-6">
        <table>
          <tbody>
            <tr v-for="(value, key) in university.first" :key="key">
              <td class="key">{{ value.key }}</td>
              <td class="value">{{ value.value }}</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="col-xs-12 col-sm-6">
        <table>
          <tbody>
            <tr v-for="(value, key) in university.second" :key="key">
              <td class="key">{{ value.key }}</td>
              <td class="value">{{ value.value }}</td>
            </tr>
          </tbody>
        </table>
      </div>
    </div>
  </div>

  <app-spinner v-else></app-spinner>
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
    parse(API_university) {
      return {
        description: API_university.description,
        first: {
          type: { key: 'Tipo', value: 'Privada' },
          initials: { key: 'Sigla', value: API_university.initials },
          freeness: { key: 'Gratuidad', value: API_university.freeness },
          foundation: { key: 'Fundación', value: API_university.foundation },
          students: { key: 'Alumnos', value: API_university.students },
        },
        second: {
          teachers: { key: 'Profesores', value: API_university.teachers },
          degrees: { key: 'Grados', value: API_university.degrees },
          postgraduates: {
            key: 'Postgrados',
            value: API_university.postgraduates,
          },
          doctorates: { key: 'Doctorados', value: API_university.doctorates },
        },
      };
    },
    fetch() {
      this.$API.universities(this.id).then(response => {
        this.university = this.parse(response);

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
.information
  padding: .5rem

  color: #7A7A7A

  .description
    margin-bottom: 1rem

  table
    width: 100%

    tr td
      padding-top: .33rem
      padding-bottom: .33rem

      &.key
        width: 40%

        color: #000000

        font-weight: 500
      
      &.value
        width: 60%
</style>
