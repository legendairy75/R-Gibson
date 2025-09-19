import { defineConfig } from 'vitepress'

// https://vitepress.dev/reference/site-config
export default defineConfig({
  title: "R.Gibson",
  description: "My Personal Website",
  head: [['link', { rel: 'icon', href: '/favicon.svg' }]],
  themeConfig: {
    // https://vitepress.dev/reference/default-theme-config
    nav: [
      { text: 'Home', link: '/' },
      { text: 'Blog', link: '/Blog' },
      { text: 'Dot Files', link '/DotFiles'}
    ],
    logo: '/favicon.svg',

    lastUpdated: {
      text: 'Updated at',
      formatOptions: {
        dateStyle: 'full',
        timeStyle: 'medium'
      }
    },

    markdown: {
      theme: {
        light: "catppuccin-latte",
        dark: "catppuccin-mocha",
      },
    },

    // sidebar: [
    //   {
    //     text: 'Examples',
    //     items: [
    //       { text: 'Markdown Examples', link: '/markdown-examples' },
    //       { text: 'Runtime API Examples', link: '/api-examples' }
    //     ]
    //   }
    // ],

    socialLinks: [
      { icon: 'github', link: 'https://github.com/legendairy75' },
      // { icon: 'twitter', link: 'https://twitter.com/legendairy75' },
      // { icon: 'facebook', link: 'https://www.facebook.com/legendairy75' },
      { icon: 'linkedin', link: 'https://www.linkedin.com/in/cameron-gibson-ab10461a8' },
    ]
  }
})
