import API from './API';

export default {
  careers(APICareer) {
    return {
      title: APICareer.title,
      university: APICareer.university,
      university_id: APICareer.university_id,
      description: APICareer.description,
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
    universities(APIUniversity, config) {
      if (config && config.params && config.params.image) {
        let university = APIUniversity.university;

        university.cover = APIUniversity.cover;
        university.profile = APIUniversity.profile;

        university.initials = 'PUC'; // Temporal

        return university;
      }

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
