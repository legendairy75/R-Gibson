<template>
  <div class="min-h-screen bg-gray-900 text-gray-100">
    <slot />
  </div>
</template>

<script setup>
// Force dark mode
const colorMode = useColorMode()
colorMode.preference = 'dark'
</script>