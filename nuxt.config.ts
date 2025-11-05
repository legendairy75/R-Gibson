import { experimental_createRouter } from "vue-router/dist/router-BbqN7H95.mjs";

import tailwindcss from "@tailwindcss/vite";


// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2025-07-15',
  devtools: { enabled: true, vscode: {} },
  modules: [
    '@nuxt/ui',
    '@nuxt/content',
    '@nuxt/eslint',
    '@nuxt/test-utils',
    '@nuxt/icon',
    '@nuxt/fonts',
    '@nuxt/image',
    // '@nuxtjs/tailwindcss'
  ],
  css: ['~/assets/css/main.css'],
  content: {
    experimental: { nativeSqlite: true },
    build: {
      markdown: {
        remarkPlugins: {
          'remark-gfm': {

          },
        }
      }
    }
  },
    image: {
        format: ['webp', 'jpg', 'png'],
    },
  app: {
    head: {

      titleTemplate: 'R.Gibson' //(res) => {
      //   return res ? `${res} - blog` : 'blog';
      // }
    }
  },
  vite: {
      plugins: [
          tailwindcss(),
      ],
  }
})