// https://nuxt.com/docs/api/configuration/nuxt-config

import tailwindcss from "@tailwindcss/vite";

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
  colorMode: {
    preference: 'dark'
  },
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
  ui: {
    global: true
  },
  vite: {
      plugins: [
          tailwindcss(),
      ],
  }
})
