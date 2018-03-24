<template>
  <div class="university">
    <div class="card z-depth-1">
      <div class="cover" :style="{ backgroundImage: `url(${university.cover})` }"></div>

      <div class="title-wrapper">
        <div class="profile-wrapper z-depth-2">
          <div class="profile" :style="{ backgroundImage: `url(${university.profile})` }"></div>
        </div>
        <div class="title">{{ university.title }}</div>
        <div class="initials">{{ university.initials }}</div>
      </div>

      <button @click="$router.push({ name: 'university' })">Información</button>
      <button @click="$router.push({ name: 'careers' })">Carreras</button>

      <router-view></router-view>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      university: null,
    };
  },
  watch: { $route: 'fetch' },
  methods: {
    fetch() {
      this.$API.universities(this.id).then(response => {
        this.university = response;

        this.$API
          .universities(this.id, { params: { image: true } })
          .then(response => {
            this.university.cover = response.cover;
            this.university.profile = response.profile;
          });
      });
    },
  },
  created() {
    this.fetch();
  },
};
</script>

<style lang="sass" scoped>
.university
  padding: 1rem

.cover
  $height: 300px

  position: relative

  display: flex
  align-items: flex-end

  height: $height

  background-position: center
  background-size: cover

.title-wrapper
  $height: 75px
  position: relative

  min-height: $height
  background-color: #00A2EC

  .profile-wrapper
    position: absolute

    $size: 75px
    top: -#{$size / 2}
    right: #{$size / 2}
    width: $size
    height: $size

    border-radius: 50%
    background-color: #FFFFFF
    display: flex
    align-items: center
    justify-content: center

    .profile
      background-position: center
      width: 75%
      height: 75%
      background-size: cover
      

  .title, .initials
    font-size: large
    color: #FFFFFF
    width: 50%
    padding: 1em
</style>
