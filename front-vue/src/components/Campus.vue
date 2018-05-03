<template>
  <a :href="`https://www.google.com/maps/search/?api=1&query=${queryAddress}`" class="campus">
    <app-icon>place</app-icon>

    <div>{{ campus.title }} <div class="address">{{ campus.address }}</div></div>
  </a>
</template>

<script>
export default {
  props: {
    campus: { type: Object, required: true },
  },
  computed: {
    queryAddress() {
      if (this.campus.lat && this.campus.long)
        return `${this.campus.lat},${this.campus.long}`;
      else return this.campus.address;
    },
  },
};
</script>

<style lang="sass" scoped>
@import './../assets/stylesheets/main'

.campus
  $padding: 1.25rem

  padding: $padding

  color: $c-black

  @include border-bottom(c-gray(200))
  @include d-flex(center)

  .icon
    color: $c-main

    @include icon(24px, $padding)
  
  .address
    color: c-gray(500)

    font-size: $f-small
</style>
