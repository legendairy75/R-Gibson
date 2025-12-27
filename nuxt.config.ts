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
    // '@nuxtjs/tailwindcss'
    '@nuxt/image',
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
    // baseURL: process.env.NODE_ENV === 'production' ? '/ncblog/' : '/',
      baseURL: '/',
      cdnURL: '/',
    head: {

      titleTemplate: 'R.Gibson',
        link: [
            {
                rel: 'icon',
                type: 'image/x-icon',
                href: '/favicon.svg'
            }
        ]
    }
  },
  nitro: {
    preset: 'github_pages',
      prerender: {
          crawlLinks: true,
          routes: ['/']
      }
  },
  vite: {
      plugins: [
          tailwindcss(),
      ],
  }
})