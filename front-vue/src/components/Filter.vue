<template>
  <div class="filter z-depth-2" v-if="fetched">
    <transition mode="out-in" @enter="enter" @leave="leave">
      <div class="filter-closed" @click="open" v-if="closed" key="closed">
        <i class="material-icons">tune</i> {{ $l.cFilter.name }}
      </div>

      <div class="filter-open" v-else key="open">
        <div class="menu">
          <button @click="close"><i class="material-icons">keyboard_arrow_down</i> {{ $l.cFilter.name }}</button>

          <button class="clear" @click="clear"><i class="material-icons">clear_all</i> {{ $l.cFilter.clear }}</button>
        </div>

        <div class="fields">
          <div class="field">
            <label for="region">{{ $l.cFilter.region }}</label>
            <app-select id="region" v-model="region" :options="regions" :default="`Todas`"></app-select>
          </div>

          <div class="field">
            <label for="city">{{ $l.cFilter.city }}</label>
            <app-select id="city" v-model="city" :options="regions" :default="`Todas`"></app-select>
          </div>
        </div>
      </div>
    </transition>
  </div>
</template>

<script>
// contador de filtros

import anime from 'animejs';

import Select from './Select.vue';

export default {
  components: {
    'app-select': Select,
  },
  data() {
    return {
      closed: true,

      cities: null,
      regions: null,

      fetched: false,

      city: 0,
      region: 0,

      duration: 250,
    };
  },
  methods: {
    parseRegionsResponse(response) {
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
      this.city = 0;
      this.region = 0;
    },
    enter(el, done) {
      if (!this.closed) {
        let height = el.offsetHeight;

        el.style.height = `${42}px`;

        anime({
          targets: el,
          height: height,
          duration: this.duration,
          easing: 'easeInOutQuad',
          complete: done,
        });
      } else {
        el.style.opacity = 0;

        anime({
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
        anime({
          targets: el,
          height: 42,
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

    .fields
      label
        margin-right: .75rem

        color: #757575

      .field
        display: flex
        align-items: center

        .select-wrapper
          flex: 1
</style>
