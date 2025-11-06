# Project Structure

## Root Level
- `nuxt.config.ts` - Main Nuxt configuration
- `content.config.ts` - Content collections and schema definitions
- `app.config.ts` - UI theme and app-level configuration
- `package.json` - Dependencies and scripts
- `tsconfig.json` - TypeScript configuration

## App Directory (`app/`)
Main application code following Nuxt 3 conventions:

### Pages (`app/pages/`)
- `index.vue` - Homepage with portfolio content
- `about.vue` - About page
- `markdown.vue` - Markdown demo page
- `blog/index.vue` - Blog listing page
- `blog/[slug].vue` - Individual blog post pages

### Components (`app/components/`)
- `AppAlert.vue` - Custom alert component
- `BarChart.vue` - Chart.js wrapper component
- `RHeader.vue` - Site header component
- `content/Card.vue` - Content-specific card component

### Layouts (`app/layouts/`)
- Contains page layout templates

### Composables (`app/composables/`)
- `mainNav.ts` - Navigation logic
- `scripts/defLay.ts` - Default layout utilities

### Assets (`app/assets/`)
- `css/main.css` - Main stylesheet
- `css/tailwind.css` - TailwindCSS imports

## Content Directory (`content/`)
Markdown content managed by Nuxt Content:

### Blog (`content/blog/`)
- Individual blog posts as `.md` files
- Each post has frontmatter with title, date, tags, image
- Uses custom components like `::card` and `::h1`

### Root Content
- `index.md` - Homepage content

## Public Directory (`public/`)
Static assets:
- `RGibson.jpg/png` - Profile images
- `favicon.ico` - Site favicon
- `_robots.txt` - SEO robots file

## Server Directory (`server/`)
Server-side code:
- `middleware/hello.ts` - Server middleware

## Generated Directories
- `.nuxt/` - Auto-generated Nuxt files (do not edit)
- `node_modules/` - Dependencies
- `.data/` - Content database files

## Naming Conventions
- Vue components use PascalCase (`AppAlert.vue`)
- Pages use kebab-case or camelCase
- Content files use camelCase (`helloWorld.md`)
- Composables use camelCase with descriptive names

## Content Schema
Blog posts require:
- `title` - Post title
- `date` - Publication date
- `tags` - Array of tag strings
- `image` - Featured image path