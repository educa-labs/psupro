<template>
  <form class="search-bar z-depth-2" :class="{ active }"
    @click="$refs.input.focus()"
  >
    <div class="input">
      <i class="material-icons">search</i>

      <input type="text" :placeholder="esCL.placeholder"
        v-model="search"
        @keypress.enter.prevent="keypressHandler"
        @input="inputHandler"
        @focus="focusHandler"
        @blur="blurHandler"
        ref="input"
      >
    </div>

    <transition name="dropdown"
      @before-enter="beforeEnter"
      @after-leave="afterLeave"
    >
      <div class="search-results" v-if="$store.state.isSearchBarFocused"><div>
        <section>
          <div>{{ esCL.searchResults.universities }}</div>

          <ul><li
            v-for="university in response.universities"
            :key="`university-${university.id}`"
          >
            <i class="material-icons">account_balance</i> {{ university.title }}
          </li></ul>
        </section>

        <section>
          <div>{{ esCL.searchResults.careers }}</div>

          <ul><li
            v-for="career in response.careers"
            :key="`career-${career.id}`"
          >
            <i class="material-icons">school</i> {{ career.title }}
          </li></ul>
        </section>
      </div></div>
    </transition>
  </form>
</template>

<script>
export default {
  props: {
    delay: { type: Number, default: 250 },
  },
  data() {
    return {
      search: '',
      searchTimeout: null,
      response: null,

      active: false,

      esCL: {
        placeholder: 'Búsqueda según carrera, universidad o ciudad',
        searchResults: {
          careers: 'Carreras',
          universities: 'Universidades',
        },
      },
    };
  },
  methods: {
    fetch() {
      this.$API.search.search(this.search).then(response => {
        this.response = response;
      });
    },
    focusHandler() {
      this.$store.dispatch('updateIsSearchBarFocused', { focus: true });
    },
    blurHandler() {
      this.$store.dispatch('updateIsSearchBarFocused', { focus: false });
    },
    inputHandler() {
      clearTimeout(this.searchTimeout);

      this.searchTimeout = setTimeout(() => {
        this.fetch();
      }, this.delay);
    },
    keypressHandler() {
      this.$store.dispatch('updateIsSearchBarFocused', { focus: false });

      let payload = { query: this.search, image: true };
      this.$store.dispatch('fetchHeavySearch', payload).then(() => {
        this.$router.push({ name: 'search' });
      });
    },
    beforeEnter() {
      this.active = true;
    },
    afterLeave() {
      this.active = false;
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.search-bar
  $border-radius: 3px

  position: relative

  z-index: 1010

  cursor: pointer

  border-radius: $border-radius
  background-color: #FFFFFF

  .input
    $padding: .75rem

    display: flex
    align-items: center

    padding: $padding

    i
      margin-right: $padding

      color: #757575

    input
      box-sizing: border-box

      width: 100%
      height: 100%

      border: none
      outline: none

      font-size: medium

    input::placeholder
      color: #8C8C8C

  .search-results
    position: absolute
    z-index: 1010
    right: 0
    left: 0

    overflow-y: scroll

    height: 200px

    border-top: 1px solid #F5F5F5
    border-bottom-right-radius: $border-radius
    border-bottom-left-radius: $border-radius
    background-color: #FFFFFF

    & > div
      padding: 1rem

      ul
        margin: 0
        padding: 0

        li
          display: flex
          align-items: center

          margin-bottom: .75rem

          i
            margin-right: 1rem

            color: #8C8C8C

    &.dropdown-enter
      height: 0

    &.dropdown-enter-active
      transition: all .25s ease

    &.dropdown-leave-active
      transition: all .25s ease

    &.dropdown-leave-to
      height: 0

.search-bar.active
  border-bottom-right-radius: 0
  border-bottom-left-radius: 0
</style>
