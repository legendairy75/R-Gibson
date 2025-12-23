<template>
  <div>
<!--    <UHeader>

      <template #title>
        R.Gibson
      </template>

      <UNavigationMenu :items="items" />

      <template #body>
      <UNavigationMenu :items="items" />
      </template>

    </UHeader>-->
    <MyHeader/>
    <UMain>
      <slot/>
    </UMain>
    <UFooter ><UNavigationMenu :items="footItems" /></UFooter>
  </div>
</template>

<script setup lang="ts">
const { footItems } = mainNav()
</script>