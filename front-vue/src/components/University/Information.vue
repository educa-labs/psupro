<template>
  <div v-if="fetched" class="information">
    <p class="description">{{ university.description }}</p>

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
/*
TODO:
  - Parse table data
  - Mostrar carreras
*/
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
  color: #000000

  .description
    margin: 0 0 1rem

    font-weight: 300

  table
    width: 100%

    border-spacing: 0

    tr td
      padding: .33rem .25rem

      border-bottom: 1px solid #E0E0E0 // Gray - 300

      &.key, &.value
        width: 50%

        font-weight: 300

      &.key
        font-weight: 400

      @media (min-width: 576px)
        &.key
          width: 40%

        &.value
          width: 60%
</style>
