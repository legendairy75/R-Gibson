import type { NavigationMenuItem } from '@nuxt/ui'

export default () => {
    const route = useRoute()

    const items = computed<NavigationMenuItem[]>(() => [
        {
            label: 'Blog',
            to: '/blog',
        },
    ])
    return {items}
}