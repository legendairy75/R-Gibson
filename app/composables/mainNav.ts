import type { NavigationMenuItem } from '@nuxt/ui'

export default () => {
    const route = useRoute()

    const items = computed<NavigationMenuItem[]>(() => [
        {
            label: 'Blog',
            to: '/blog',
            icon: 'i-lucide-pen'
        }, {
            label: 'Dot files',
            to: '/dotfiles',
            icon: 'i-lucide-folder-dot'
        },{
            label: 'Gitron',
            to: 'https://git.ron-gibson.com',
            icon: 'i-lucide-folder-git-2'
        }
        {
            label: 'Notes',
            to: 'https://github.com/legendairy75/notes',
            icon: 'i-lucide-book-open',
            active: route.path.startsWith('/docs/getting-started')
        },
    ]);
    const footItems = computed<NavigationMenuItem[]>(() => [
        {
            label: 'Blog',
            to: '/blog',
            icon: 'i-lucide-pen'
        },
    ])
    return {items, footItems}
}