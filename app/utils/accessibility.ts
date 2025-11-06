/**
 * Accessibility validation utilities for Catppuccin theme
 * Validates color contrast ratios and WCAG compliance
 */

// Catppuccin Mocha color palette (hex values)
export const catppuccinMocha = {
  // Base colors
  base: '#1e1e2e',
  mantle: '#181825',
  crust: '#11111b',

  // Surface colors
  surface0: '#313244',
  surface1: '#45475a',
  surface2: '#585b70',

  // Overlay colors
  overlay0: '#6c7086',
  overlay1: '#7f849c',
  overlay2: '#9399b2',

  // Text colors
  subtext0: '#a6adc8',
  subtext1: '#bac2de',
  text: '#cdd6f4',

  // Accent colors
  rosewater: '#f5e0dc',
  flamingo: '#f2cdcd',
  pink: '#f5c2e7',
  mauve: '#cba6f7',
  red: '#f38ba8',
  maroon: '#eba0ac',
  peach: '#fab387',
  yellow: '#f9e2af',
  green: '#a6e3a1',
  teal: '#94e2d5',
  sky: '#89dceb',
  sapphire: '#74c7ec',
  blue: '#89b4fa',
  lavender: '#b4befe'
}

/**
 * Convert hex color to RGB values
 */
function hexToRgb(hex: string): { r: number; g: number; b: number } | null {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex)
  return result ? {
    r: parseInt(result[1], 16),
    g: parseInt(result[2], 16),
    b: parseInt(result[3], 16)
  } : null
}

/**
 * Calculate relative luminance of a color
 * Based on WCAG 2.1 specification
 */
function getRelativeLuminance(r: number, g: number, b: number): number {
  const [rs, gs, bs] = [r, g, b].map(c => {
    c = c / 255
    return c <= 0.03928 ? c / 12.92 : Math.pow((c + 0.055) / 1.055, 2.4)
  })
  return 0.2126 * rs + 0.7152 * gs + 0.0722 * bs
}

/**
 * Calculate contrast ratio between two colors
 * Returns a value between 1 and 21
 */
export function getContrastRatio(color1: string, color2: string): number {
  const rgb1 = hexToRgb(color1)
  const rgb2 = hexToRgb(color2)

  if (!rgb1 || !rgb2) return 1

  const l1 = getRelativeLuminance(rgb1.r, rgb1.g, rgb1.b)
  const l2 = getRelativeLuminance(rgb2.r, rgb2.g, rgb2.b)

  const lighter = Math.max(l1, l2)
  const darker = Math.min(l1, l2)

  return (lighter + 0.05) / (darker + 0.05)
}

/**
 * WCAG compliance levels
 */
export const WCAGLevels = {
  AA_NORMAL: 4.5,      // Normal text AA
  AA_LARGE: 3,         // Large text AA
  AAA_NORMAL: 7,       // Normal text AAA
  AAA_LARGE: 4.5       // Large text AAA
} as const

/**
 * Check if contrast ratio meets WCAG standards
 */
export function isWCAGCompliant(
  contrastRatio: number,
  level: 'AA' | 'AAA' = 'AA',
  textSize: 'normal' | 'large' = 'normal'
): boolean {
  const threshold = level === 'AA'
    ? (textSize === 'normal' ? WCAGLevels.AA_NORMAL : WCAGLevels.AA_LARGE)
    : (textSize === 'normal' ? WCAGLevels.AAA_NORMAL : WCAGLevels.AAA_LARGE)

  return contrastRatio >= threshold
}

/**
 * Validate all critical color combinations in the theme
 */
export function validateThemeAccessibility() {
  const results = []

  // Critical color combinations used in the app
  const colorCombinations = [
    // Text on backgrounds
    { name: 'Text on Base', foreground: catppuccinMocha.text, background: catppuccinMocha.base },
    { name: 'Text on Surface0', foreground: catppuccinMocha.text, background: catppuccinMocha.surface0 },
    { name: 'Text on Surface1', foreground: catppuccinMocha.text, background: catppuccinMocha.surface1 },

    // Subtext on backgrounds
    { name: 'Subtext1 on Base', foreground: catppuccinMocha.subtext1, background: catppuccinMocha.base },
    { name: 'Subtext0 on Base', foreground: catppuccinMocha.subtext0, background: catppuccinMocha.base },

    // Primary colors (mauve) on backgrounds
    { name: 'Mauve on Base', foreground: catppuccinMocha.mauve, background: catppuccinMocha.base },
    { name: 'Mauve on Surface0', foreground: catppuccinMocha.mauve, background: catppuccinMocha.surface0 },

    // Secondary colors (lavender) on backgrounds
    { name: 'Lavender on Base', foreground: catppuccinMocha.lavender, background: catppuccinMocha.base },
    { name: 'Lavender on Surface0', foreground: catppuccinMocha.lavender, background: catppuccinMocha.surface0 },

    // Info colors (green) on backgrounds
    { name: 'Green on Base', foreground: catppuccinMocha.green, background: catppuccinMocha.base },
    { name: 'Green on Surface0', foreground: catppuccinMocha.green, background: catppuccinMocha.surface0 },

    // Interactive elements
    { name: 'Blue on Base', foreground: catppuccinMocha.blue, background: catppuccinMocha.base },
    { name: 'Red on Base', foreground: catppuccinMocha.red, background: catppuccinMocha.base },
  ]

  for (const combo of colorCombinations) {
    const contrastRatio = getContrastRatio(combo.foreground, combo.background)
    const isAACompliant = isWCAGCompliant(contrastRatio, 'AA', 'normal')
    const isAAACompliant = isWCAGCompliant(contrastRatio, 'AAA', 'normal')
    const isAALargeCompliant = isWCAGCompliant(contrastRatio, 'AA', 'large')

    results.push({
      name: combo.name,
      foreground: combo.foreground,
      background: combo.background,
      contrastRatio: Math.round(contrastRatio * 100) / 100,
      compliance: {
        'AA Normal': isAACompliant,
        'AA Large': isAALargeCompliant,
        'AAA Normal': isAAACompliant
      }
    })
  }

  return results
}

/**
 * Generate accessibility report
 */
export function generateAccessibilityReport() {
  const results = validateThemeAccessibility()

  console.log('🎨 Catppuccin Theme Accessibility Report')
  console.log('=' .repeat(50))

  let passCount = 0
  let totalTests = 0

  results.forEach(result => {
    console.log(`\n📋 ${result.name}`)
    console.log(`   Contrast Ratio: ${result.contrastRatio}:1`)
    console.log(`   Foreground: ${result.foreground}`)
    console.log(`   Background: ${result.background}`)

    Object.entries(result.compliance).forEach(([level, passes]) => {
      const status = passes ? '✅ PASS' : '❌ FAIL'
      console.log(`   ${level}: ${status}`)
      if (passes) passCount++
      totalTests++
    })
  })

  console.log('\n' + '=' .repeat(50))
  console.log(`📊 Summary: ${passCount}/${totalTests} tests passed (${Math.round(passCount/totalTests*100)}%)`)

  // Recommendations
  const failedTests = results.filter(r => !r.compliance['AA Normal'])
  if (failedTests.length > 0) {
    console.log('\n⚠️  Recommendations:')
    failedTests.forEach(test => {
      if (test.contrastRatio < WCAGLevels.AA_NORMAL) {
        console.log(`   • ${test.name}: Consider using a darker background or lighter foreground`)
      }
    })
  } else {
    console.log('\n🎉 All critical color combinations meet WCAG AA standards!')
  }

  return {
    results,
    summary: {
      total: totalTests,
      passed: passCount,
      percentage: Math.round(passCount/totalTests*100)
    }
  }
}

/**
 * Color blindness simulation utilities
 */
export const colorBlindnessFilters = {
  protanopia: 'url(#protanopia)',      // Red-blind
  deuteranopia: 'url(#deuteranopia)', // Green-blind
  tritanopia: 'url(#tritanopia)',     // Blue-blind
  achromatopsia: 'url(#achromatopsia)' // Complete color blindness
}

/**
 * Generate SVG filters for color blindness simulation
 */
export function generateColorBlindnessFilters(): string {
  return `
    <svg style="position: absolute; width: 0; height: 0;" aria-hidden="true">
      <defs>
        <!-- Protanopia (Red-blind) -->
        <filter id="protanopia">
          <feColorMatrix type="matrix" values="0.567 0.433 0 0 0
                                               0.558 0.442 0 0 0
                                               0 0.242 0.758 0 0
                                               0 0 0 1 0"/>
        </filter>

        <!-- Deuteranopia (Green-blind) -->
        <filter id="deuteranopia">
          <feColorMatrix type="matrix" values="0.625 0.375 0 0 0
                                               0.7 0.3 0 0 0
                                               0 0.3 0.7 0 0
                                               0 0 0 1 0"/>
        </filter>

        <!-- Tritanopia (Blue-blind) -->
        <filter id="tritanopia">
          <feColorMatrix type="matrix" values="0.95 0.05 0 0 0
                                               0 0.433 0.567 0 0
                                               0 0.475 0.525 0 0
                                               0 0 0 1 0"/>
        </filter>

        <!-- Achromatopsia (Complete color blindness) -->
        <filter id="achromatopsia">
          <feColorMatrix type="matrix" values="0.299 0.587 0.114 0 0
                                               0.299 0.587 0.114 0 0
                                               0.299 0.587 0.114 0 0
                                               0 0 0 1 0"/>
        </filter>
      </defs>
    </svg>
  `
}