<template>
  <div class="filter z-depth-2" v-if="fetched">
    <transition mode="out-in" @enter="enter" @leave="leave">
      <div class="filter-closed" @click="open" v-if="closed" key="filter-closed">
        <i class="material-icons">tune</i> {{ $l.cFilter.name }} <span class="counter z-depth-1" v-if="count > 0">{{ count }}</span>
      </div>

      <div class="filter-open" v-else key="filter-open">
        <div class="menu">
          <button @click="close"><i class="material-icons">keyboard_arrow_down</i> {{ $l.cFilter.name }} <span class="counter z-depth-1" v-if="count > 0">{{ count }}</span></button>

          <button @click="clear"><i class="material-icons">clear_all</i> {{ $l.cFilter.clear }}</button>
        </div>

        <form>
          <div class="field">
            <label for="region">{{ $l.cFilter.region }}</label>
            <app-select id="region" :options="regions" :default="$l.cFilter.default"
              v-model="filters.region"
              @input="fetchSearchResponse"
            ></app-select>
          </div>

          <div class="field">
            <label for="city">{{ $l.cFilter.city }}</label>
            <app-select id="city" :options="regions" :default="$l.cFilter.default"
              v-model="filters.city"
              @input="fetchSearchResponse"
            ></app-select>
          </div>
        </form>
      </div>
    </transition>
  </div>
</template>

<script>
import Select from './Select.vue';

export default {
  props: {
    height: { type: Number, default: 42 },
  },
  components: {
    'app-select': Select,
  },
  data() {
    return {
      fetched: false,

      cities: null,
      regions: null,

      filters: {
        city: 0,
        region: 0,
      },

      closed: true,
      duration: 250,
    };
  },
  computed: {
    count() {
      return Object.values(this.filters).reduce((before, current) => {
        return (before += current && 1);
      }, 0);
    },
  },
  methods: {
    parseCitiesResponse(response) {},
    parseRegionsResponse(response) {
      // { id: 1, title: 'Tarapacá' } => { key: 'Tarapacá', value: 1 }

      return response.map(region => {
        let { id: value, title: key } = region;

        return Object.assign({}, { key, value });
      });
    },
    fetch() {
      Promise.all([
        /*
        this.$API.cities().then(response => {
          this.cities = response;
        }),
        */
        this.$API.regions().then(response => {
          this.regions = this.parseRegionsResponse(response);
        }),
      ]).then(() => {
        this.fetched = true;
      });
    },
    fetchSearchResponse() {
      this.close();

      this.$store.dispatch('clearSearchResponse').then(() => {
        let payload = {
          query: this.$store.state.search.query,
          filters: this.filters,
          image: true,
        };

        this.$store.dispatch('fetchSearchResponse', payload);
      });
    },
    open() {
      this.$store.dispatch('showOverlay', {
        handleClick: () => {
          this.close();
        },
        zIndex: 1015,
      });

      this.closed = false;
    },
    close() {
      this.$store.dispatch('hideOverlay');

      this.closed = true;
    },
    clear() {
      this.filters.city = this.filters.region = 0;
    },
    enter(el, done) {
      if (!this.closed) {
        let height = el.offsetHeight;

        el.style.height = `${this.height}px`;

        this.$a({
          targets: el,
          height: height,
          duration: this.duration,
          easing: 'easeInOutQuad',
          complete: done,
        });
      } else {
        el.style.opacity = 0;

        this.$a({
          targets: el,
          opacity: 1,
          duration: Math.floor(this.duration / 2),
          easing: 'easeInOutQuad',
          complete: done,
        });
      }
    },
    leave(el, done) {
      if (this.closed) {
        this.$a({
          targets: el,
          height: this.height,
          opacity: 0,
          duration: this.duration,
          easing: 'easeInOutQuad',
          complete: done,
        });
      } else done();
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.filter
  position: fixed
  z-index: 1020
  right: 0
  bottom: 0
  left: 0

  background-color: #FFFFFF

  @media (min-width: 576px)
    right: 50%
    left: 50%

    width: 576px

    transform: translateX(-50%)

    border-top-left-radius: 2px
    border-top-right-radius: 2px

  .filter-closed
    display: flex
    align-items: center
    justify-content: center

    height: 42px

    cursor: pointer
    user-select: none

    color: #757575

    .material-icons
      margin-right: .75rem

  .filter-open
    padding-right: 1rem
    padding-left: 1rem

    transform-origin: bottom

    .menu
      display: flex
      align-items: center
      justify-content: space-between

      height: 42px

      button
        color: #757575

        font-size: medium
    
        .material-icons
          margin-right: .25rem

    form
      height: 200px

      label
        margin-right: .75rem

        color: #757575

      .field
        display: flex
        align-items: center

        .select-wrapper
          flex: 1

.counter
  width: 20px
  height: 20px
  margin-left: .5rem

  text-align: center

  color: #FFFFFF
  border-radius: 50%
  background-color: #00A2EC

  font-size: small
  line-height: 20px
</style>
