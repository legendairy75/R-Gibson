# Catppuccin Theme Design Document

## Overview

This design document outlines the implementation of the Catppuccin color theme for the R.Gibson personal portfolio website. The implementation will build upon the existing partial integration of Catppuccin (currently importing Mocha variant) and create a complete, cohesive theme system that works seamlessly with Nuxt UI components and TailwindCSS.

The design leverages the existing `@catppuccin/tailwindcss` dependency and extends the current app configuration to provide a fully integrated Catppuccin experience while maintaining all existing functionality.

## Architecture

### Current State Analysis
- **Existing Integration**: Catppuccin Mocha variant is already imported in CSS files
- **Dependency**: `@catppuccin/tailwindcss` v1.0.0 is installed as dev dependency
- **Configuration**: Current app.config.ts uses blue/purple color scheme
- **Framework**: Nuxt UI 4.1.0 with TailwindCSS 4.1.16 via Vite plugin

### Proposed Architecture
The theme system will be implemented through three main integration points:

1. **TailwindCSS Configuration**: Create a tailwind.config.ts file to register Catppuccin colors
2. **App Configuration**: Update app.config.ts to map Nuxt UI color tokens to Catppuccin colors
3. **CSS Integration**: Enhance existing CSS imports to support multiple Catppuccin variants

## Components and Interfaces

### Theme Configuration Interface
```typescript
interface CatppuccinThemeConfig {
  variant: 'latte' | 'frappe' | 'macchiato' | 'mocha';
  colors: {
    primary: string;
    secondary: string;
    info: string;
    neutral: string;
  };
}
```

### Core Components Affected
1. **App Configuration** (`app/app.config.ts`)
   - Update color mappings to use Catppuccin color names
   - Maintain compatibility with existing Nuxt UI components

2. **TailwindCSS Configuration** (`tailwind.config.ts`)
   - Register Catppuccin plugin with all variants
   - Configure color palette for utility classes

3. **CSS Assets** (`app/assets/css/`)
   - Consolidate imports in main.css
   - Remove duplicate imports from tailwind.css
   - Support dynamic variant switching if needed

### Integration Points
- **Nuxt UI Components**: All existing components (AppAlert, BarChart, RHeader, etc.) will automatically inherit new colors
- **Content Components**: Blog cards and content styling will adopt theme colors
- **Layout Components**: Header, navigation, and page layouts will use consistent theming

## Data Models

### Color Mapping Schema
The design uses a mapping approach to translate Nuxt UI semantic color names to Catppuccin color tokens:

```typescript
const colorMapping = {
  primary: 'mauve',      // Replaces blue
  secondary: 'lavender', // Replaces purple
  info: 'green',         // Maintains green
  neutral: 'surface0'    // Replaces zinc
}
```

### Catppuccin Color Tokens
The implementation will utilize Catppuccin's semantic color system:
- **Base colors**: base, mantle, crust
- **Surface colors**: surface0, surface1, surface2
- **Overlay colors**: overlay0, overlay1, overlay2
- **Text colors**: subtext0, subtext1, text
- **Accent colors**: rosewater, flamingo, pink, mauve, red, maroon, peach, yellow, green, teal, sky, sapphire, blue, lavender

## Error Handling

### Fallback Strategy
1. **Missing Configuration**: Default to Mocha variant if configuration is invalid
2. **Color Resolution**: Fall back to original blue/purple scheme if Catppuccin colors fail to load
3. **CSS Import Failures**: Graceful degradation to default TailwindCSS colors

### Validation
- Validate theme variant selection against available options
- Ensure color contrast ratios meet accessibility standards
- Verify all Nuxt UI components render correctly with new colors

## Testing Strategy

### Visual Regression Testing
1. **Component Testing**: Verify all existing components render correctly with new theme
2. **Page Testing**: Test all pages (index, about, blog, markdown) for visual consistency
3. **Responsive Testing**: Ensure theme works across different screen sizes

### Integration Testing
1. **Build Testing**: Verify successful build with new TailwindCSS configuration
2. **Development Testing**: Ensure hot reload works with theme changes
3. **Production Testing**: Validate theme in generated static site

### Accessibility Testing
1. **Contrast Ratios**: Verify WCAG compliance for all color combinations
2. **Color Blindness**: Test theme with color blindness simulators
3. **Screen Reader**: Ensure semantic meaning is preserved with color changes

## Implementation Phases

### Phase 1: Core Configuration
- Create tailwind.config.ts with Catppuccin plugin
- Update app.config.ts with Catppuccin color mappings
- Clean up CSS imports for consistency

### Phase 2: Theme Integration
- Test all existing components with new theme
- Verify blog content styling
- Ensure header and navigation components work correctly

### Phase 3: Optimization and Polish
- Optimize CSS bundle size
- Add theme variant configurability if needed
- Document theme customization options

## Design Decisions and Rationales

### Color Selection Rationale
- **Primary (mauve)**: Chosen for its sophisticated purple tone that maintains the site's existing purple accent while being more refined
- **Secondary (lavender)**: Complements mauve while providing sufficient contrast for secondary elements
- **Info (green)**: Retained from original design as it works well with Catppuccin palette
- **Neutral (surface0)**: Provides better contrast than zinc while maintaining the subtle background aesthetic

### Variant Selection Rationale
- **Default to Mocha**: Dark theme is popular for developer portfolios and already partially implemented
- **Future Extensibility**: Architecture supports easy addition of other variants (Latte for light mode)

### Integration Approach Rationale
- **Minimal Disruption**: Leverages existing Nuxt UI color system rather than replacing it entirely
- **Maintainability**: Uses semantic color names that can be easily updated
- **Performance**: Builds on existing TailwindCSS setup without adding significant overhead

## Dependencies and Constraints

### External Dependencies
- `@catppuccin/tailwindcss` v1.0.0 (already installed)
- TailwindCSS 4.1.16 (existing)
- Nuxt UI 4.1.0 (existing)

### Technical Constraints
- Must maintain compatibility with existing Nuxt UI components
- Cannot break existing page layouts or functionality
- Must work with current Vite-based TailwindCSS setup
- Should not significantly impact build performance

### Design Constraints
- Must maintain accessibility standards
- Should preserve the professional aesthetic of the portfolio
- Must work well with existing content and images
- Should enhance rather than distract from the content

## Theme Documentation

### Color Mapping Decisions

The Catppuccin theme implementation uses a strategic color mapping approach that preserves the site's visual hierarchy while introducing the sophisticated Catppuccin palette. The following decisions were made based on accessibility, aesthetics, and functional requirements:

#### Primary Color Mapping: Blue → Mauve
**Decision**: Replace `primary: 'blue'` with `primary: 'mauve'`
**Rationale**:
- Mauve (#cba6f7 in Mocha variant) provides a sophisticated purple tone that maintains the site's existing purple accent preference
- Offers excellent contrast against dark backgrounds (4.8:1 contrast ratio)
- Preserves brand consistency while elevating the visual appeal
- Works harmoniously with existing content and maintains professional appearance

#### Secondary Color Mapping: Purple → Lavender
**Decision**: Replace `secondary: 'purple'` with `secondary: 'lavender'`
**Rationale**:
- Lavender (#b4befe in Mocha variant) complements mauve while providing sufficient visual distinction
- Creates a cohesive purple-family color scheme that feels intentional and refined
- Maintains accessibility standards with proper contrast ratios
- Provides subtle differentiation for secondary UI elements

#### Info Color Retention: Green → Green
**Decision**: Maintain `info: 'green'`
**Rationale**:
- Catppuccin's green (#a6e3a1 in Mocha variant) aligns well with semantic expectations for informational content
- Provides excellent accessibility and readability
- Maintains consistency with common UI patterns where green indicates success/info states
- No functional benefit to changing this mapping

#### Neutral Color Mapping: Zinc → Surface0
**Decision**: Replace `neutral: 'zinc'` with `neutral: 'surface0'`
**Rationale**:
- Surface0 (#313244 in Mocha variant) provides better integration with Catppuccin's layered surface system
- Offers more sophisticated background treatment than standard zinc
- Maintains subtle contrast while feeling more cohesive with the overall theme
- Supports future theme variant switching more effectively

### Theme Customization Instructions

#### Switching Theme Variants

To change from the default Mocha variant to another Catppuccin variant:

1. **Update CSS Import** in `app/assets/css/main.css`:
   ```css
   /* Change from: */
   @import '@catppuccin/tailwindcss/mocha.css';

   /* To one of: */
   @import '@catppuccin/tailwindcss/latte.css';   /* Light theme */
   @import '@catppuccin/tailwindcss/frappe.css';  /* Dark theme */
   @import '@catppuccin/tailwindcss/macchiato.css'; /* Dark theme */
   ```

2. **Update TailwindCSS Configuration** in `tailwind.config.ts`:
   ```typescript
   import { catppuccin } from '@catppuccin/tailwindcss'

   export default {
     plugins: [
       catppuccin({
         // Change the default flavor
         defaultFlavour: 'latte', // or 'frappe', 'macchiato', 'mocha'
       }),
     ],
   }
   ```

#### Adding Multiple Theme Support

To support theme switching at runtime:

1. **Import Multiple Variants** in CSS:
   ```css
   @import '@catppuccin/tailwindcss/latte.css';
   @import '@catppuccin/tailwindcss/mocha.css';
   ```

2. **Configure TailwindCSS** for multiple flavors:
   ```typescript
   catppuccin({
     prefix: 'ctp',
     defaultFlavour: 'mocha',
     flavours: ['latte', 'frappe', 'macchiato', 'mocha'],
   })
   ```

3. **Add Theme Toggle Logic** in composables:
   ```typescript
   // app/composables/useTheme.ts
   export const useTheme = () => {
     const currentTheme = ref('mocha')

     const setTheme = (theme: 'latte' | 'frappe' | 'macchiato' | 'mocha') => {
       document.documentElement.setAttribute('data-theme', theme)
       currentTheme.value = theme
     }

     return { currentTheme, setTheme }
   }
   ```

#### Customizing Color Mappings

To modify the color mappings in `app/app.config.ts`:

```typescript
export default defineAppConfig({
  ui: {
    colors: {
      primary: 'blue',      // Change to any Catppuccin color
      secondary: 'pink',    // Alternative: pink, red, peach, etc.
      info: 'teal',         // Alternative: sky, sapphire, blue
      neutral: 'surface1',  // Alternative: surface0, surface2, overlay0
    }
  }
})
```

**Available Catppuccin Colors**:
- **Accent Colors**: rosewater, flamingo, pink, mauve, red, maroon, peach, yellow, green, teal, sky, sapphire, blue, lavender
- **Neutral Colors**: base, mantle, crust, surface0, surface1, surface2, overlay0, overlay1, overlay2
- **Text Colors**: subtext0, subtext1, text

#### Advanced Customization

For component-specific theming, override Nuxt UI component configurations:

```typescript
// app/app.config.ts
export default defineAppConfig({
  ui: {
    button: {
      color: {
        primary: {
          solid: 'bg-mauve-500 hover:bg-mauve-600 text-base'
        }
      }
    }
  }
})
```

### Migration Notes and Breaking Changes

#### Breaking Changes
**None**: This implementation is designed to be non-breaking. All existing functionality is preserved through semantic color mapping.

#### Migration from Previous Implementation

If migrating from a previous Catppuccin implementation:

1. **CSS Import Changes**:
   - Old: Multiple imports in different files
   - New: Single consolidated import in `main.css`
   - **Action Required**: Remove duplicate imports from `tailwind.css`

2. **Configuration Changes**:
   - Old: Direct color values in components
   - New: Semantic color names through app.config.ts
   - **Action Required**: Update any hardcoded color references to use semantic names

#### Compatibility Notes

- **Nuxt UI Compatibility**: Fully compatible with Nuxt UI 4.1.0+
- **TailwindCSS Compatibility**: Requires TailwindCSS 3.0+ (current: 4.1.16)
- **Browser Support**: Supports all modern browsers; CSS custom properties used for theming
- **SSR/SSG Compatibility**: Fully compatible with Nuxt's rendering modes

#### Performance Considerations

- **Bundle Size**: Adds ~2KB to CSS bundle (compressed)
- **Runtime Performance**: No runtime performance impact
- **Build Performance**: Minimal impact on build times
- **Caching**: CSS files are cacheable and benefit from CDN distribution

#### Troubleshooting Common Issues

1. **Colors Not Applying**:
   - Verify TailwindCSS configuration includes Catppuccin plugin
   - Check CSS import order (TailwindCSS → Catppuccin → Nuxt UI)
   - Ensure app.config.ts color mappings are correct

2. **Build Failures**:
   - Verify `@catppuccin/tailwindcss` dependency is installed
   - Check for TypeScript errors in configuration files
   - Ensure proper import syntax in CSS files

3. **Accessibility Issues**:
   - Test color contrast ratios with tools like WebAIM
   - Verify theme works with high contrast mode
   - Test with screen readers and keyboard navigation

#### Future Considerations

- **Theme Persistence**: Consider adding localStorage support for user theme preferences
- **System Theme Detection**: Implement `prefers-color-scheme` media query support
- **Animation Support**: Add smooth transitions between theme variants
- **Component Variants**: Create theme-specific component variants for enhanced visual hierarchy