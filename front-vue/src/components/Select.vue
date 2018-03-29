<template>
  <div class="select-wrapper">
    <input type="text" class="select-dropdown" readonly="true"
      @click="handleInputClick"
      @blur="handleBlur"
    >

    <transition name="dropdown">
      <ul class="z-depth-1"
        :style="{ 'max-height': `${maxHeight}px` }"
        v-show="open"
        ref="ul"
      >
        <li
          v-for="(value, key, index) in options"
          :key="`option-${key}`"
          :class="{ selected: selected === index }"
          @click="handleOptionClick(index)"
        >{{ key }}</li>
      </ul>
    </transition>

    <select id="region">
      <option value="Todas">Todas</option>
      <option value="1">I Región de Tarapacá</option>
    </select>
  </div>
</template>

<script>
export default {
  data() {
    return {
      open: false,
      selected: null,
      mounted: false,
      maxHeight: 0,

      options: {
        Todas: 'Todas',
        'I Región de Tarapacá': 1,
      },
    };
  },
  computed: {
    /*
    maxHeight() {
      if (!this.mounted) return;

      let maxHeight = Array.from(this.$refs.ul.children).reduce(
        (before, current) => {
          return (before += current.offsetHeight);
        },
        0
      );

      return 100;
    },
    */
  },
  methods: {
    handleInputClick() {
      this.open = true;

      console.log('Open!');
    },
    handleBlur() {
      this.open = false;
    },
    handleOptionClick(index) {
      this.selected = index;
    },
  },
  mounted() {
    this.mounted = true;
  },
  updated() {
    let maxHeight = Array.from(this.$refs.ul.children).reduce(
      (before, current) => {
        return (before += current.offsetHeight);
      },
      0
    );

    console.log(maxHeight);

    this.maxHeight = maxHeight;
  },
};
</script>

<style lang="sass" scoped>
select
  display: none

.select-wrapper
  position: relative

  ul
    position: absolute

    overflow: hidden

    padding: 1rem 0

    list-style-type: none

    color: #000000

    li
      padding: 14px 16px

      cursor: pointer
    
    li.selected
      background-color: rgba(0, 0, 0, 0.03)
    
    li:focus, li:hover
      background-color: rgba(0, 0, 0, 0.08)

    &.dropdown-enter
      max-height: 0 !important

    &.dropdown-enter-active
      transition: max-height .1s

    &.dropdown-leave-active
      transition: max-height .1s

    &.dropdown-leave-to
      max-height: 0 !important
</style>
