<template>
  <div class="min-h-screen">
    <UPageHeader
      title="Accessibility Testing"
      description="Test and validate the Catppuccin theme accessibility compliance"
    />

    <UContainer class="py-8">
      <!-- Accessibility Report -->
      <UCard class="mb-8">
        <template #header>
          <h2 class="text-xl font-semibold">WCAG Compliance Report</h2>
        </template>

        <div v-if="accessibilityReport">
          <div class="mb-6">
            <div class="flex items-center justify-between mb-4">
              <h3 class="text-lg font-medium">Overall Score</h3>
              <div class="text-2xl font-bold" :class="getScoreColor(accessibilityReport.summary.percentage)">
                {{ accessibilityReport.summary.percentage }}%
              </div>
            </div>
            <UProgress
              :value="accessibilityReport.summary.percentage"
              :color="getProgressColor(accessibilityReport.summary.percentage)"
              size="lg"
            />
            <p class="text-sm text-gray-600 mt-2">
              {{ accessibilityReport.summary.passed }} of {{ accessibilityReport.summary.total }} tests passed
            </p>
          </div>

          <!-- Detailed Results -->
          <div class="space-y-4">
            <h3 class="text-lg font-medium">Color Combination Tests</h3>
            <div class="grid gap-4">
              <UCard
                v-for="result in accessibilityReport.results"
                :key="result.name"
                variant="outline"
              >
                <div class="flex items-start justify-between">
                  <div class="flex-1">
                    <h4 class="font-medium">{{ result.name }}</h4>
                    <p class="text-sm text-gray-600 mb-2">
                      Contrast Ratio: <span class="font-mono">{{ result.contrastRatio }}:1</span>
                    </p>
                    <div class="flex gap-2 mb-3">
                      <div
                        class="w-6 h-6 rounded border"
                        :style="{ backgroundColor: result.foreground }"
                        :title="`Foreground: ${result.foreground}`"
                      ></div>
                      <div
                        class="w-6 h-6 rounded border"
                        :style="{ backgroundColor: result.background }"
                        :title="`Background: ${result.background}`"
                      ></div>
                    </div>
                    <div class="flex gap-3 text-sm">
                      <span
                        v-for="(passes, level) in result.compliance"
                        :key="level"
                        :class="passes ? 'text-green-600' : 'text-red-600'"
                      >
                        {{ passes ? '✓' : '✗' }} {{ level }}
                      </span>
                    </div>
                  </div>
                  <div
                    class="ml-4 p-3 rounded text-center min-w-[100px]"
                    :style="{ backgroundColor: result.background, color: result.foreground }"
                  >
                    <div class="font-medium">Sample</div>
                    <div class="text-sm">Text</div>
                  </div>
                </div>
              </UCard>
            </div>
          </div>
        </div>

        <div v-else class="text-center py-8">
          <UButton @click="runAccessibilityTest" loading-icon="i-lucide-loader-2">
            Run Accessibility Test
          </UButton>
        </div>
      </UCard>

      <!-- Theme Color Palette -->
      <UCard class="mb-8">
        <template #header>
          <h2 class="text-xl font-semibold">Catppuccin Color Palette</h2>
        </template>

        <div class="grid grid-cols-2 md:grid-cols-4 lg:grid-cols-6 gap-4">
          <div
            v-for="(color, name) in catppuccinColors"
            :key="name"
            class="text-center"
          >
            <div
              class="w-full h-16 rounded-lg border mb-2"
              :style="{ backgroundColor: color }"
            ></div>
            <div class="text-sm font-medium">{{ formatColorName(name) }}</div>
            <div class="text-xs text-gray-500 font-mono">{{ color }}</div>
          </div>
        </div>
      </UCard>

      <!-- Component Examples -->
      <UCard class="mb-8">
        <template #header>
          <h2 class="text-xl font-semibold">Component Examples</h2>
        </template>

        <div class="space-y-6">
          <!-- Buttons -->
          <div>
            <h3 class="text-lg font-medium mb-3">Buttons</h3>
            <div class="flex flex-wrap gap-3">
              <UButton color="primary">Primary Button</UButton>
              <UButton color="secondary">Secondary Button</UButton>
              <UButton color="info">Info Button</UButton>
              <UButton variant="outline" color="primary">Outline Primary</UButton>
              <UButton variant="ghost" color="primary">Ghost Primary</UButton>
            </div>
          </div>

          <!-- Alerts -->
          <div>
            <h3 class="text-lg font-medium mb-3">Alerts</h3>
            <div class="space-y-3">
              <UAlert
                color="primary"
                variant="solid"
                title="Primary Alert"
                description="This is a primary alert with Catppuccin mauve color."
              />
              <UAlert
                color="info"
                variant="outline"
                title="Info Alert"
                description="This is an info alert with Catppuccin green color."
              />
            </div>
          </div>

          <!-- Form Elements -->
          <div>
            <h3 class="text-lg font-medium mb-3">Form Elements</h3>
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
              <UInput placeholder="Sample input field" />
              <USelect
                :options="[
                  { label: 'Option 1', value: '1' },
                  { label: 'Option 2', value: '2' }
                ]"
                placeholder="Select an option"
              />
            </div>
          </div>

          <!-- Typography -->
          <div>
            <h3 class="text-lg font-medium mb-3">Typography</h3>
            <div class="space-y-2">
              <h1 class="text-4xl font-bold text-primary">Heading 1 (Primary)</h1>
              <h2 class="text-3xl font-semibold text-secondary">Heading 2 (Secondary)</h2>
              <h3 class="text-2xl font-medium">Heading 3 (Default)</h3>
              <p class="text-base">Regular paragraph text with normal contrast.</p>
              <p class="text-sm text-gray-600">Small text with reduced contrast.</p>
            </div>
          </div>
        </div>
      </UCard>
    </UContainer>

    <!-- Accessibility Tester Component -->
    <AccessibilityTester />
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue'
import { validateThemeAccessibility, catppuccinMocha } from '~/utils/accessibility'

// Page metadata
definePageMeta({
  title: 'Accessibility Testing'
})

// Reactive data
const accessibilityReport = ref(null)
const catppuccinColors = catppuccinMocha

// Methods
function runAccessibilityTest() {
  const results = validateThemeAccessibility()
  const passCount = results.reduce((count, result) => {
    return count + Object.values(result.compliance).filter(Boolean).length
  }, 0)
  const totalTests = results.length * 3 // 3 compliance levels per test

  accessibilityReport.value = {
    results,
    summary: {
      total: totalTests,
      passed: passCount,
      percentage: Math.round((passCount / totalTests) * 100)
    }
  }
}

function getScoreColor(percentage: number): string {
  if (percentage >= 90) return 'text-green-600'
  if (percentage >= 75) return 'text-yellow-600'
  return 'text-red-600'
}

function getProgressColor(percentage: number): string {
  if (percentage >= 90) return 'green'
  if (percentage >= 75) return 'yellow'
  return 'red'
}

function formatColorName(name: string): string {
  return name.charAt(0).toUpperCase() + name.slice(1)
}

// Auto-run test on mount
onMounted(() => {
  runAccessibilityTest()
})
</script>