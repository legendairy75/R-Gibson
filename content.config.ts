import { defineContentConfig, defineCollection } from '@nuxt/content'
import { z } from 'zod'

export default defineContentConfig({
  collections: {
    content: defineCollection({
      type: 'page',
      source: '**/*.md'
    }),
      blog: defineCollection({
          type: 'page',
          source: 'blog/*.md',
          // Define custom schema for docs collection
          schema: z.object({
              tags: z.array(z.string()),
              image: z.string(),
              date: z.date()
          })
      })
  }
})
