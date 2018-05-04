<template>
  <div class="select">
    <input type="text" readonly :value="_options[index].key" @click="open">

    <app-icon>arrow_drop_down</app-icon>
  </div>
</template>

<script>
export default {
  props: {
    value: {
      type: Number,
      default: 0,
    },
    options: {
      type: Array,
      required: true,
    },
    default: {
      type: String,
    },
  },
  data() {
    return {
      _options: null,
      index: 0,
    };
  },
  watch: {
    options(newOptions) {
      this.parseOptions(newOptions);
    },
  },
  methods: {
    parseOptions(options) {
      this._options = JSON.parse(JSON.stringify(options));

      if (this.default) {
        this._options.unshift({ value: 0, key: this.default });
      }
    },
    open() {
      this.$store.dispatch('mountOverlayComponent', {
        is: 'app-select-options',
        payload: {
          options: this._options,
          handleOptionClick: this.handleOptionClick,
        },
      });
    },
    handleOptionClick(index) {
      this.index = index;

      this.$emit('input', this._options[index].value);
    },
  },
  created() {
    this.parseOptions(this.options);
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.select
  position: relative

  cursor: pointer

  input
    width: 100%
    padding-right: 1rem
    padding-left: 1rem

    @include canvas(2px, c-gray(100))
    @include text-height(3rem)
    @include user-select(none)

  .icon
    margin-top: auto
    margin-bottom: auto

    color: $c-black
    background-color: transparent

    @include icon(24px, .5rem)
    @include p-absolute(1, 0, 0, 0, unset)
</style>
