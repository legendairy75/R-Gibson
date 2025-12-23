<script setup lang="ts">
import type { NavigationMenuItem } from '@nuxt/ui'

const route = useRoute()

const { items } = mainNav()
</script>

<template>
  <UHeader>
    <template #title>
     <img
         src="/favicon.svg"
         alt="logo"
         class="h-8 w-8"
     />
      R. Gibson
    </template>

    <template #right>
      <UNavigationMenu :items="items" />
      <UColorModeButton />

      <UTooltip text="Open on GitHub" :kbds="['meta', 'G']">
        <UButton
            color="neutral"
            variant="ghost"
            to="https://github.com/legendairy75"
            target="_blank"
            icon="i-simple-icons-github"
            aria-label="GitHub"
        />
      </UTooltip>
      <UTooltip text="Open on Linkedin" :kbds="['meta', 'G']">
        <UButton
            color="neutral"
            variant="ghost"
            to="https://www.linkedin.com/in/cameron-gibson-ab10461a8"
            target="_blank"
            icon="i-simple-icons-linkedin"
            aria-label="GitHub"
        />
      </UTooltip>
    </template>

    <template #body>
      <UNavigationMenu :items="items" orientation="vertical" class="-mx-2.5" />
    </template>
  </UHeader>
</template>

