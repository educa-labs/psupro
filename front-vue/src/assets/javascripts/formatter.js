import accounting from './accounting.min'; // AccountingJS
import store from './../../store/store'; // Vuex

accounting.settings = {
  currency: {
    symbol: '$',
    format: '%s%v',
    decimal: ',',
    thousand: '.',
    precision: 0,
  },
  number: {
    precision: 0,
    thousand: '.',
    decimal: ',',
  },
};

const formatter = {
  ...accounting,
  formatCareer(APICareer) {
    Object.values(APICareer.weighing).forEach(
      weight => (weight.value = weight.value ? `${weight.value}%` : undefined)
    );

    let minScore = APICareer.minScore.value;

    APICareer.minScore.value = minScore
      ? formatter.formatNumber(minScore)
      : undefined;

    let vacancies = APICareer.information.vacancies.value;

    APICareer.information.vacancies.value = vacancies
      ? formatter.formatNumber(vacancies)
      : undefined;

    let averageSalary = APICareer.information.averageSalary.value;

    APICareer.information.averageSalary.value = averageSalary
      ? formatter.formatMoney(averageSalary)
      : undefined;

    let tariff = APICareer.information.tariff.value;

    APICareer.information.tariff.value = tariff
      ? formatter.formatMoney(tariff)
      : undefined;

    let employability = APICareer.information.employability.value;

    APICareer.information.employability.value = employability
      ? `${employability}%`
      : undefined;

    APICareer.information.duration.value = `${
      APICareer.information.duration.value
    } ${store.state.locale.cCareer.semesters}`.toLowerCase();

    return APICareer;
  },
  formatUniversity(APIUniversity) {
    let foundation = new Date(APIUniversity.foundation).toLocaleDateString(
      store.state.locale.name,
      {
        day: 'numeric',
        month: 'long',
        year: 'numeric',
      }
    );

    let freeness = APIUniversity.freeness ? 'Sí' : 'No';

    return {
      id: APIUniversity.id,
      description: APIUniversity.description,
      first: {
        type: { key: 'Tipo', value: APIUniversity.u_type },
        initials: { key: 'Sigla', value: APIUniversity.initials },
        freeness: { key: 'Gratuidad', value: freeness },
        foundation: { key: 'Fundación', value: foundation },
        students: {
          key: 'Alumnos',
          value: formatter.formatNumber(APIUniversity.students),
        },
      },
      second: {
        teachers: {
          key: 'Profesores',
          value: formatter.formatNumber(APIUniversity.teachers),
        },
        degrees: {
          key: 'Grados',
          value: formatter.formatNumber(APIUniversity.degrees),
        },
        postgraduates: {
          key: 'Postgrados',
          value: formatter.formatNumber(APIUniversity.postgraduates),
        },
        doctorates: {
          key: 'Doctorados',
          value: formatter.formatNumber(APIUniversity.doctorates),
        },
      },
    };
  },
};

export default formatter;
