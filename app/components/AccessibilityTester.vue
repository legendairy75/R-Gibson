<template>
  <UCard class="accessibility-tester">
    <template #header>
      <div class="flex items-center justify-between">
        <h3 class="text-lg font-semibold">Accessibility Tester</h3>
        <UButton
          @click="isExpanded = !isExpanded"
          variant="ghost"
          size="sm"
          :icon="isExpanded ? 'i-lucide-chevron-up' : 'i-lucide-chevron-down'"
        >
          {{ isExpanded ? 'Hide' : 'Show' }} Tools
        </UButton>
      </div>
    </template>

    <div v-if="isExpanded" class="space-y-6">
      <!-- Color Blindness Simulation -->
      <div>
        <h4 class="text-md font-medium mb-3">Color Blindness Simulation</h4>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-2">
          <UButton
            v-for="(filter, type) in colorBlindnessFilters"
            :key="type"
            @click="applyColorBlindnessFilter(type)"
            :variant="activeFilter === type ? 'solid' : 'outline'"
            size="sm"
            class="text-xs"
          >
            {{ formatFilterName(type) }}
          </UButton>
        </div>
        <p class="text-sm text-gray-500 mt-2">
          Click a filter to simulate different types of color blindness. Click "Normal" to reset.
        </p>
      </div>

      <!-- Contrast Checker -->
      <div>
        <h4 class="text-md font-medium mb-3">Live Contrast Checker</h4>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
          <div>
            <label class="block text-sm font-medium mb-1">Foreground Color</label>
            <input
              v-model="foregroundColor"
              type="color"
              class="w-full h-10 rounded border"
              @input="updateContrastRatio"
            >
            <input
              v-model="foregroundColor"
              type="text"
              class="w-full mt-1 px-2 py-1 text-sm border rounded"
              placeholder="#cdd6f4"
              @input="updateContrastRatio"
            >
          </div>
          <div>
            <label class="block text-sm font-medium mb-1">Background Color</label>
            <input
              v-model="backgroundColor"
              type="color"
              class="w-full h-10 rounded border"
              @input="updateContrastRatio"
            >
            <input
              v-model="backgroundColor"
              type="text"
              class="w-full mt-1 px-2 py-1 text-sm border rounded"
              placeholder="#1e1e2e"
              @input="updateContrastRatio"
            >
          </div>
        </div>

        <!-- Contrast Results -->
        <div class="mt-4 p-4 rounded-lg border" :style="{ backgroundColor: backgroundColor, color: foregroundColor }">
          <p class="font-medium">Sample Text Preview</p>
          <p class="text-sm">This is how your text will look with the selected colors.</p>
        </div>

        <div class="mt-3 grid grid-cols-1 md:grid-cols-3 gap-3">
          <div class="text-center p-3 rounded-lg border">
            <div class="text-lg font-bold">{{ contrastRatio }}:1</div>
            <div class="text-sm text-gray-600">Contrast Ratio</div>
          </div>
          <div class="text-center p-3 rounded-lg border" :class="wcagAA ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200'">
            <div class="text-lg font-bold" :class="wcagAA ? 'text-green-600' : 'text-red-600'">
              {{ wcagAA ? '✓' : '✗' }}
            </div>
            <div class="text-sm text-gray-600">WCAG AA</div>
          </div>
          <div class="text-center p-3 rounded-lg border" :class="wcagAAA ? 'bg-green-50 border-green-200' : 'bg-red-50 border-red-200'">
            <div class="text-lg font-bold" :class="wcagAAA ? 'text-green-600' : 'text-red-600'">
              {{ wcagAAA ? '✓' : '✗' }}
            </div>
            <div class="text-sm text-gray-600">WCAG AAA</div>
          </div>
        </div>
      </div>

      <!-- Theme Color Samples -->
      <div>
        <h4 class="text-md font-medium mb-3">Catppuccin Theme Colors</h4>
        <div class="grid grid-cols-2 md:grid-cols-4 gap-3">
          <div
            v-for="(color, name) in themeColors"
            :key="name"
            class="p-3 rounded-lg border text-center cursor-pointer hover:scale-105 transition-transform"
            :style="{ backgroundColor: color, color: getTextColor(color) }"
            @click="setColorsFromTheme(color)"
          >
            <div class="font-medium text-sm">{{ formatColorName(name) }}</div>
            <div class="text-xs opacity-75">{{ color }}</div>
          </div>
        </div>
        <p class="text-sm text-gray-500 mt-2">
          Click any color to use it as the foreground color in the contrast checker.
        </p>
      </div>
    </div>

    <!-- SVG Filters for Color Blindness Simulation -->
    <div v-html="colorBlindnessFiltersSVG" class="hidden"></div>
  </UCard>
</template>

<script setup lang="ts">
import { ref, computed, onMounted } from 'vue'
import { getContrastRatio, isWCAGCompliant, catppuccinMocha, generateColorBlindnessFilters } from '~/utils/accessibility'

const isExpanded = ref(false)
const activeFilter = ref('normal')
const foregroundColor = ref('#cdd6f4') // Catppuccin text
const backgroundColor = ref('#1e1e2e')  // Catppuccin base

// Color blindness filters
const colorBlindnessFilters = {
  normal: 'none',
  protanopia: 'url(#protanopia)',
  deuteranopia: 'url(#deuteranopia)',
  tritanopia: 'url(#tritanopia)',
  achromatopsia: 'url(#achromatopsia)'
}

// Theme colors for testing
const themeColors = {
  ...catppuccinMocha
}

// SVG filters for color blindness simulation
const colorBlindnessFiltersSVG = generateColorBlindnessFilters()

// Computed contrast values
const contrastRatio = computed(() => {
  const ratio = getContrastRatio(foregroundColor.value, backgroundColor.value)
  return Math.round(ratio * 100) / 100
})

const wcagAA = computed(() => isWCAGCompliant(contrastRatio.value, 'AA', 'normal'))
const wcagAAA = computed(() => isWCAGCompliant(contrastRatio.value, 'AAA', 'normal'))

// Methods
function applyColorBlindnessFilter(filterType: string) {
  activeFilter.value = filterType
  const filter = colorBlindnessFilters[filterType as keyof typeof colorBlindnessFilters]

  // Apply filter to the entire page
  if (typeof document !== 'undefined') {
    document.documentElement.style.filter = filter
  }
}

function formatFilterName(type: string): string {
  const names = {
    normal: 'Normal',
    protanopia: 'Protanopia',
    deuteranopia: 'Deuteranopia',
    tritanopia: 'Tritanopia',
    achromatopsia: 'Achromatopsia'
  }
  return names[type as keyof typeof names] || type
}

function formatColorName(name: string): string {
  return name.charAt(0).toUpperCase() + name.slice(1)
}

function updateContrastRatio() {
  // Trigger reactivity
  contrastRatio.value
}

function setColorsFromTheme(color: string) {
  foregroundColor.value = color
  updateContrastRatio()
}

function getTextColor(backgroundColor: string): string {
  // Simple logic to determine if text should be light or dark
  const ratio = getContrastRatio('#ffffff', backgroundColor)
  return ratio > 4.5 ? '#ffffff' : '#000000'
}

// Cleanup on unmount
onUnmounted(() => {
  if (typeof document !== 'undefined') {
    document.documentElement.style.filter = 'none'
  }
})
</script>

<style scoped>
.accessibility-tester {
  position: fixed;
  bottom: 20px;
  right: 20px;
  max-width: 400px;
  z-index: 1000;
  max-height: 80vh;
  overflow-y: auto;
}

@media (max-width: 768px) {
  .accessibility-tester {
    position: relative;
    bottom: auto;
    right: auto;
    max-width: none;
    margin: 20px 0;
  }
}
</style>