const preprocessors = {
  careers(API_career) {
    return {
      minScore: { key: 'Corte 2017', value: API_career.last_cut },
      weighing: {
        language: { key: 'Lenguaje', value: API_career.weighing.language },
        mathematics: { key: 'Matemáticas', value: API_career.weighing.math },
        sciences: { key: 'Ciencias', value: API_career.weighing.science },
        nem: { key: 'NEM', value: API_career.weighing.NEM },
        ranking: { key: 'Ranking', value: API_career.weighing.ranking },
      },
      information: {
        area: { key: 'Área', value: API_career.area_title },
        vacancies: { key: 'Vacantes', value: API_career.openings },
        duration: { key: 'Duración', value: API_career.semesters },
        tariff: { key: 'Arancel', value: API_career.price },
        averageSalary: { key: 'Sueldo promedio', value: API_career.income },
        employability: {
          key: 'Empleabilidad',
          value: API_career.employability,
        },
      },
    };
  },
  universities(API_university) {
    return API_university;
  },
  search: {
    careers(API_careers) {
      return API_careers;
    },
    universities(API_universities) {
      return API_universities;
    },
    search(careers, universities) {
      return { careers, universities };
    },
  },
};

export default preprocessors;
