<template>
  <transition name="fade">
    <div class="university-container" v-if="fetched">
      <div class="card university z-depth-1">
        <div class="cover" :style="{ backgroundImage: `url(${university.cover})` }">
          <a href=""><i class="material-icons" @click="$router.go(-1)">arrow_back</i></a>

          <div class="profile z-depth-2"><div :style="{ backgroundImage: `url(${university.profile})` }"></div></div>
        </div>

        <div class="card-title">
          <div>{{ university.title }} <br> {{ university.initials }}</div>
        </div>

        <ul class="tabs z-depth-1">
          <li class="tab"><a @click="$router.replace({ name: 'university' })">{{ esCL.tabs.information }}</a></li>
          <li class="tab"><a @click="$router.replace({ name: 'careers' })">{{ esCL.tabs.careers }}</a></li>

          <!-- <li class="indicator"></li> -->
        </ul>

        <div class="card-content">
          <router-view></router-view>
        </div>
      </div>
    </div> 
  </transition>
</template>

<script>
export default {
  props: {
    id: { type: Number, required: true },
  },
  data() {
    return {
      university: null,
      fetched: false,

      esCL: {
        tabs: {
          information: 'Información',
          careers: 'Carreras',
        },
      },
    };
  },
  methods: {
    fetch() {
      this.$API.universities(this.id).then(response => {
        this.university = response;

        this.$API
          .universities(this.id, { params: { image: true } })
          .then(response => {
            this.university.cover = response.cover;
            this.university.profile = response.profile;

            this.fetched = true;
          });
      });
    },
  },
  created() {
    this.fetch();

    this.$store.dispatch('updateTest', { test: true }); // Temporal
  },
};
</script>

<style lang="sass" scoped>
.university-container
  padding: 1rem

.university
  .cover
    $height: 300px

    position: relative

    height: $height

    background-position: center
    background-size: cover

    a i
      position: absolute
      top: 1rem
      left: 1rem

    .profile
      $size: 75px

      position: absolute
      z-index: 2
      right: #{$size / 2}
      bottom: -#{$size / 2}

      display: flex
      align-items: center
      justify-content: center

      width: $size
      height: $size

      border-radius: 50%
      background-color: #FFFFFF

      & > div
        width: 75%
        height: 75%

        background-position: center
        background-size: cover

  .card-title
    $height: 75px

    z-index: 1

    min-height: $height

    background-color: #00A2EC

    & > div
      width: 50%
      padding: 1rem

      font-size: large

  &.fade-enter
    opacity: 0

  &.fade-enter-active
    transition: opacity .25s ease

// Tabs - Temporal

.tabs
  display: flex

  padding: 0

  text-align: center

  background-color: rgb(0, 171, 241)
  
  li
    flex: 1

    a
      padding: 0

.indicator
  right: 467px
  left: 0
</style>
