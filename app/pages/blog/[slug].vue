<script lang="ts" setup>
const route = useRoute()
const { data: page } = await useAsyncData(route.path, () => {
  return queryCollection('blog').path(route.path).first()
})
</script>

<template>
    <ContentRenderer v-if="page" :value="page"/>
    <div v-else>Page not found</div>
</template>
