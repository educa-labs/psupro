import API from './API';

export default {
  careers(APICareer) {
    return {
      university_id: APICareer.university_id,
      weighing: {
        language: { key: 'Lenguaje', value: APICareer.weighing.language },
        mathematics: { key: 'Matemáticas', value: APICareer.weighing.math },
        sciences: { key: 'Ciencias', value: APICareer.weighing.science },
        nem: { key: 'NEM', value: APICareer.weighing.NEM },
        ranking: { key: 'Ranking', value: APICareer.weighing.ranking },
      },
      minScore: { key: 'Corte 2017', value: APICareer.last_cut },
      information: {
        area: { key: 'Área', value: APICareer.area_title },
        vacancies: { key: 'Vacantes', value: APICareer.openings },
        duration: { key: 'Duración', value: APICareer.semesters },
        tariff: { key: 'Arancel', value: APICareer.price },
        averageSalary: { key: 'Sueldo promedio', value: APICareer.income },
        employability: {
          key: 'Empleabilidad',
          value: APICareer.employability,
        },
      },
      image: null,
    };
  },
  universities: {
    universities(APIUniversity) {
      if (!APIUniversity.cover) APIUniversity.cover = null;
      if (!APIUniversity.profile) APIUniversity.profile = null;

      return APIUniversity;
    },
    campus(APICampus) {
      return APICampus;
    },
    careers(APICareers) {
      return APICareers;
    },
  },
  search(APISearch) {
    return {
      careers: APISearch.carreers,
      universities: APISearch.universities,
    };
  },
  constants: {
    regions(APIRegions) {
      return APIRegions;
    },
    degreeTypes(APIDegreeTypes) {
      return APIDegreeTypes;
    },
    cities(APICities) {
      return APICities;
    },
  },
};
