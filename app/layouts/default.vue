<template>
  <div>
    <UHeader>

      <template #title>
        R.Gibson
      </template>

      <UNavigationMenu :items="items" />

      <template #body>
      <UNavigationMenu :items="items" />
      </template>

    </UHeader>
    <UMain>
      <slot/>
    </UMain>
    <UFooter ><UNavigationMenu :items="items" /></UFooter>
  </div>
</template>

<script setup lang="ts">
const { items } = mainNav()
</script>