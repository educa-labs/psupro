<template>
  <div class="select-wrapper">
    <input type="text" class="select-dropdown" readonly="true"
      :value="_options[value].key"
      @click="open = true"
      @blur="open = false"
    >

    <i class="material-icons">arrow_drop_down</i>

    <transition name="dropdown">
      <ul class="z-depth-1" @mousedown.prevent v-show="open">
        <li class="disabled">{{ $l.cSelect.tip }}</li>
        <li
          v-for="(value, index) in _options"
          :key="`option-${index}`"
          :class="{ selected: value === index}"
          @click="handleOptionClick(index)"
        >{{ value.key }}</li>
      </ul>
    </transition>
  </div>
</template>

<script>
// revisar stilos
// scrolleable
// aparecer en el centro
// width

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

      open: false,
    };
  },
  methods: {
    handleOptionClick(index) {
      this.open = false;

      this.$emit('input', this._options[index].value);
    },
  },
  created() {
    this._options = JSON.parse(JSON.stringify(this.options));

    if (this.default) {
      this._options.unshift({ value: 0, key: this.default });
    }
  },
};
</script>

<style lang="sass" scoped>
select
  display: none

.select-wrapper
  position: relative

  display: inline-block

  input
    position: relative
    z-index: 1

    display: inline-block

    height: 3rem

    padding: 0

    cursor: pointer
    user-select: none

    border: none
    outline: none

    font-size: medium
    line-height: 3rem
  
  .material-icons
    position: absolute
    z-index: 1
    top: 0
    right: 0
    bottom: 0

    width: 24px
    height: 24px
    margin: auto 0

    color: #000000
    background-color: #FFFFFF

    font-size: 24px

  ul
    position: absolute
    z-index: 1
    bottom: 0
    left: 0

    overflow-y: scroll

    max-height: 100px

    margin: 0

    padding: 1rem 0

    list-style-type: none

    transform-origin: left bottom

    color: #000000
    background-color: #FFFFFF

    li
      padding: 14px 16px

      cursor: pointer
    
    li.selected
      background-color: rgba(0, 0, 0, 0.03)
    
    li:focus, li:hover
      background-color: rgba(0, 0, 0, 0.08)
    
    li.disabled
      color: #9E9E9E
      background-color: #FFFFFF

    &.dropdown-enter
      transform: scale(0, 0)

    &.dropdown-enter-active
      transition: transform .05s
</style>
