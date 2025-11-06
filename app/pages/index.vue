<template>
  <UPageHero title="R.Gibson" orientation="horizontal">

    <template #description>
      <h2 class="text-primary">Web Developer</h2>
    </template>

    <img src="/RGibson.png" alt="R.Gibson" width='350' style="border-radius: 50%" class="border-4 border-primary">
  </UPageHero>

  <UPageCard
  class="content"
  description="Hello! My name Is Cameron Gibson and I'm a backend web developer. I started programming when I was a child
  and built programs with js and visual basic. I can build a simple webpage using html, build an app with express.js or NUXT.js."
  >

    <template #title>
      <h2 class="text-3xl text-primary">About</h2>
    </template>

  </UPageCard>

  <UPageCard>

    <template #title>
      <h2 class="text-3xl text-primary">Skills</h2>
    </template>

  <UPageList>
    <UPageCard
        v-for="(skill, index) in skills"
        :key="index"
        variant="ghost"
        :target="skill.target"
    >
      <template #body>
        <UUser :name="skill.name" :description="skill.description" size="xl" class="relative" />
      </template>
    </UPageCard>
  </UPageList>
  </UPageCard>

  <UPageCard
  title="Contact"
  description="roncrash1@gmail.com"/>

  <UPageCard>
    <template #title>
      <h2 class="text-3xl text-primary">My Work</h2>
    </template>
  <UPageList>
    <UPageCard
        v-for="(work, index) in works"
        :key="index"
        variant="ghost"
    >
      <template #body>
        <UUser :name="work.name" :description="work.description" size="xl" class="relative" />
      </template>
    </UPageCard>
  </UPageList>
  </UPageCard>

  <UPageCard title="Checkout my blog" to="blog"/>

</template>
<script setup lang="ts">
const skills = ref([
  {
    name: 'Javascript',
    // description: 'benjamincanac',
    // to: 'https://github.com/benjamincanac',
    target: '_blank',
  },
  {
    name: 'Node.js',
    target: '_blank',
  },
  {
    name: 'Vue.js',
    target: '_blank',
  },
  {
    name: 'Nuxt.js',
    target: '_blank',
  },
  {
    name: 'MongoDB',
    target: '_blank',
  },
  // {
  //   name: 'CSS',
  //   target: '_blank',
  // },
])
const works = ref([
  {
    name:'Beer Me'
  },
  {
    name:'Yelp Camp'
  },
  {
    name:'Marine Tower'
  }
])
</script>