# Technology Stack

## Framework & Core
- **Nuxt.js 4.2.0** - Vue.js meta-framework for SSR/SSG
- **Vue.js 3.5.22** - Frontend framework
- **TypeScript** - Type-safe JavaScript

## UI & Styling
- **Nuxt UI 4.1.0** - Component library
- **TailwindCSS 4.1.16** - Utility-first CSS framework
- **Catppuccin** - Color theme for TailwindCSS

## Content Management
- **Nuxt Content 3.7.1** - File-based CMS with markdown support
- **SQLite** - Content database (experimental native SQLite)
- **Remark GFM** - GitHub Flavored Markdown support
- **Zod** - Schema validation for content

## Additional Features
- **Chart.js & Vue-ChartJS** - Data visualization
- **Nuxt Image** - Optimized image handling (WebP, JPG, PNG)
- **Nuxt Icon** - Icon management
- **Nuxt Fonts** - Font optimization

## Development Tools
- **ESLint** - Code linting
- **Nuxt DevTools** - Development utilities

## Common Commands

### Development
```bash
pnpm dev          # Start development server on localhost:3000
pnpm build        # Build for production
pnpm generate     # Generate static site
pnpm preview      # Preview production build locally
```

### Package Management
- Uses **pnpm** as the preferred package manager
- Run `pnpm install` to install dependencies
- `pnpm postinstall` runs `nuxt prepare` automatically

## Configuration Notes
- Uses experimental native SQLite for content
- TailwindCSS configured via Vite plugin
- Custom app config defines UI color scheme (primary: blue, secondary: purple)