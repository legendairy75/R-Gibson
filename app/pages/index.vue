<template>
  <UPageHero color="secondary" title="R.Gibson" orientation="horizontal">

    <template #description>
      <h2 class="text-primary">Devops</h2>
    </template>

    <img src="/RGibson.png" alt="R.Gibson" width='350' style="border-radius: 50%">
  </UPageHero>

  <UPageCard
  class="content"
  :description='aboutDescription'
  >

    <template #title>
      <h2 class="text-3xl">About</h2>
    </template>

  </UPageCard>
  <UPageCard>

    <template #title>
      <h2 class="text-3xl">Skills</h2>
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
      <h2 class="text-3xl">My Work</h2>
    </template>
  <UPageList>
    <UPageCard
        v-for="(work, index) in works"
        :key="index"
        variant="ghost"
    >
      <template #body>
        <UUser :name="work.name" :to="work.to" :description="work.description" size="xl" class="relative" />
      </template>
    </UPageCard>
  </UPageList>
  </UPageCard>

  <UPageCard title="Checkout my blog" to="blog"/>

</template>
<script setup lang="ts">
import aboutDescription from '../../assets/description.md?raw'
const skills = ref([
  {
    name: 'linux',
    // description: 'benjamincanac',
    target: '_blank',
  },
])
const works = ref([
  {
    name:'Beer Me',
    to: 'https://beerme2-20014575297.us-central1.run.app/',
    target: '_blank',
  },
  {
    name:'Marine Tower',
    to: 'https://legendairy75.itch.io/marine-tower',
  },
])
</script>