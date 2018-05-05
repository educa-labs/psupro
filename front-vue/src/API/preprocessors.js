import API from './API';

export default {
  careers(APICareer) {
    let weighingSciencesValue = APICareer.weighing.science,
      weighingHistoryValue = APICareer.weighing.history;

    let weighingSHKey = 'Ciencias o Historia';
    let weighingSHValue = weighingSciencesValue;

    if (weighingSciencesValue && !weighingHistoryValue) {
      weighingSHKey = 'Ciencias';
      weighingSHValue = weighingSciencesValue;
    } else if (!weighingSciencesValue && weighingHistoryValue) {
      weighingSHKey = 'Historia';
      weighingSHValue = weighingHistoryValue;
    }

    return {
      university_title: APICareer.university_title,
      campu_name: APICareer.campu_name,
      title: APICareer.title,
      university: APICareer.university,
      university_id: APICareer.university_id,
      description: APICareer.description,
      campus_id: APICareer.campu_id,
      cover: APICareer.area_picture,
      id: APICareer.id,
      weighing: {
        language: { key: 'Lenguaje', value: APICareer.weighing.language },
        mathematics: { key: 'Matemáticas', value: APICareer.weighing.math },
        sh: { key: weighingSHKey, value: weighingSHValue },
        nem: { key: 'NEM', value: APICareer.weighing.NEM },
        ranking: { key: 'Ranking', value: APICareer.weighing.ranking },
      },
      minScore: { key: 'Puntaje de corte 2017', value: APICareer.last_cut },
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
  similar(APISimilarCareers) {
    return APISimilarCareers.slice(0);
  },
  universities: {
    universities(APIUniversity, config) {
      if (config && config.params && config.params.image) {
        let university = APIUniversity.university;

        university.cover = APIUniversity.cover;
        university.profile = APIUniversity.profile;

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
