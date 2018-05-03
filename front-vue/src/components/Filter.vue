<template>
  <div class="filter z-depth-2" v-if="fetched">
    <transition mode="out-in" @enter="enter" @leave="leave">
      <div class="filter-closed" @click="open" v-if="closed" key="filter-closed">
        <app-icon>tune</app-icon> {{ $l.cFilter.name }} <span class="counter z-depth-1" v-if="count > 0">{{ count }}</span>
      </div>

      <div class="filter-open" v-else key="filter-open">
        <div class="menu">
          <button @click="close"><app-icon>keyboard_arrow_down</app-icon> {{ $l.cFilter.name }} <span class="counter z-depth-1" v-if="count > 0">{{ count }}</span></button>

          <button @click="clear"><app-icon>clear_all</app-icon> {{ $l.cFilter.clear }}</button>
        </div>

        <form>
          <label for="region">{{ $l.cFilter.region }}</label>
          <app-select id="region" :options="regions" :default="$l.cFilter.default"
            v-model="filters.region"
            @input="fetchSearchResponse2"
          ></app-select>

          <label for="city">{{ $l.cFilter.city }}</label>
          <app-select id="city" :options="cities" :default="$l.cFilter.default"
            v-model="filters.city"
            @input="fetchSearchResponse"
          ></app-select>

          <label for="degree-type">{{ $l.cFilter.degreeType }}</label>
          <app-select id="degree-type" :options="degreeTypes" :default="$l.cFilter.default"
            v-model="filters.degreeType"
            @input="fetchSearchResponse"
          ></app-select>
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
      degreeTypes: null,
      regions: null,

      filters: {
        city: 0,
        degree_type: 0,
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
    format(response) {
      // { id: A, title: B } to { key: B, value: A }

      return response.map(region => {
        let { id: value, title: key } = region;

        return Object.assign({}, { key, value });
      });
    },
    fetch() {
      Promise.all([
        this.$API.constants.cities().then(response => {
          this.cities = this.format(response);
        }),
        this.$API.constants.degreeTypes().then(response => {
          this.degreeTypes = this.format(response);
        }),
        this.$API.constants.regions().then(response => {
          this.regions = this.format(response);
        }),
      ]).then(() => {
        this.fetched = true;
      });
    },
    fetchSearchResponse() {
      this.$store.dispatch('clearSearchResponse').then(() => {
        let payload = {
          query: this.$store.state.search.query,
          filters: this.filters,
        };

        this.$store.dispatch('fetchSearchResponse', payload);
      });
    },
    fetchSearchResponse2() {
      this.$emit('filter', this.filters);
    },
    open() {
      this.$store.dispatch('showOverlay', { method: this.close, zIndex: 1015 });

      this.closed = false;
    },
    close() {
      this.$store.dispatch('hideOverlay');

      this.closed = true;
    },
    clear() {
      Object.keys(this.filters).forEach(key => (this.filters[key] = 0));

      this.fetchSearchResponse();
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
@import './../assets/stylesheets/main'

.filter
  background-color: $c-white

  @include media-up(sm)
    width: $breakpoint-sm

    transform: translateX(-50%)

    @include border-top-radius(2px)
    @include position(null, 50%, null, 50%)

  @include p-fixed(1020, null, 0, 0, 0)

  .filter-closed
    height: 42px

    cursor: pointer

    color: c-gray(600)

    @include d-flex(center, center)
    @include user-select(none)

    .icon
      @include icon(24px, .75rem)

  .filter-open
    padding-right: 1rem
    padding-left: 1rem

    transform-origin: bottom

    .menu
      height: 42px

      @include d-flex(center, space-between)

      button
        color: c-gray(600)

        font-size: $f-medium
    
        .icon
          @include icon(24px, .25rem)

      button:first-child
        color: $c-black

    form
      display: grid
      align-items: center

      grid-template-columns: auto 1fr
      grid-row-gap: 1rem

      label
        margin-right: .75rem

        color: c-gray(600)

.filter .counter
  margin-left: .5rem

  text-align: center

  color: $c-white
  background-color: $c-main

  font-size: $f-small

  @include circle(20px)
</style>
