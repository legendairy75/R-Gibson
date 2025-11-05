<script setup lang="ts">
const { data: posts } = await useAsyncData('blog', () => queryCollection('blog').all())
</script>

<template>
  <div>
    <h1>Blog</h1>
    <ul>
      <li v-for="post in posts" :key="post.id">
        <ULink :to="post.path">{{ post.title }}</ULink>
      </li>
    </ul>
  </div>
</template>