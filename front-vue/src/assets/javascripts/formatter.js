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
  formatCareer(API_career) {
    Object.values(API_career.weighing).forEach(
      weight => (weight.value = `${weight.value}%`)
    );

    API_career.minScore.value = formatter.formatNumber(
      API_career.minScore.value
    );
    API_career.information.vacancies.value = formatter.formatNumber(
      API_career.information.vacancies.value
    );
    API_career.information.averageSalary.value = formatter.formatMoney(
      API_career.information.averageSalary.value
    );
    API_career.information.tariff.value = formatter.formatMoney(
      API_career.information.tariff.value
    );
    API_career.information.employability.value = `${
      API_career.information.employability.value
    }%`;
    API_career.information.duration.value = `${
      API_career.information.duration.value
    } ${store.state.locale.cCareer.semesters}`.toLowerCase();

    return API_career;
  },
  formatUniversity(API_university) {
    let foundation = new Date(API_university.foundation).toLocaleDateString(
      store.state.locale.name,
      {
        day: 'numeric',
        month: 'long',
        year: 'numeric',
      }
    );

    let freeness = API_university.freeness ? 'Sí' : 'No';

    return {
      id: API_university.id,
      description: API_university.description,
      first: {
        type: { key: 'Tipo', value: 'Privada' },
        initials: { key: 'Sigla', value: API_university.initials },
        freeness: { key: 'Gratuidad', value: freeness },
        foundation: { key: 'Fundación', value: foundation },
        students: {
          key: 'Alumnos',
          value: formatter.formatNumber(API_university.students),
        },
      },
      second: {
        teachers: {
          key: 'Profesores',
          value: formatter.formatNumber(API_university.teachers),
        },
        degrees: {
          key: 'Grados',
          value: formatter.formatNumber(API_university.degrees),
        },
        postgraduates: {
          key: 'Postgrados',
          value: formatter.formatNumber(API_university.postgraduates),
        },
        doctorates: {
          key: 'Doctorados',
          value: formatter.formatNumber(API_university.doctorates),
        },
      },
    };
  },
};

export default formatter;
