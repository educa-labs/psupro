<template>
  <div v-if="fetched" class="careers">
    <div class="description">{{ university.description }}</div>
  </div>
  <div v-else>Loading...</div>
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
.careers
  padding: .5rem

  color: #7A7A7A
</style>
