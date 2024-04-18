import { createRouter, createWebHistory } from 'vue-router'
import LayoffsView from '../views/LayoffsView.vue'

const router = createRouter({
	history: createWebHistory(import.meta.env.BASE_URL),
	routes: [
		{
			path: '/',
			redirect: '/layoffs'
		}, 
		{
			path: '/layoffs',
			name: 'layoffs',
			component: LayoffsView
		},
		{
			path: '/trends/people',
			name: 'trends-people',
			component: () => import('../views/TrendsPeopleView.vue')
		},
		{
			path: '/trends/events',
			name: 'trends-events',
			component: () => import('../views/TrendsEventsView.vue')
		},
		{
			path: '/companies',
			name: 'companies',
			component: () => import('../views/CompaniesView.vue')
		}, 
		{
			path: '/companies/:id',
			name: 'company-detail',
			component: () => import('../views/CompanyDetailView.vue')
		},
		{
			path: '/forums',
			name: 'forums',
			component: () => import('../views/ForumsView.vue')
		},
		{
			path: '/forums/:id',
			name: 'forums-post',
			component: () => import('../views/ForumsPostView.vue')
		},
		{
			path: '/resources',
			name: 'resources',
			component: () => import('../views/ResourcesView.vue')
		}, 
		{
			path: '/resources/:id',
			name: 'resources-article',
			component: () => import('../views/ResourcesArticleView.vue')
		}, 
		{
			path: '/users/:id',
			name: 'users',
			component: () => import('../views/UsersView.vue')
		}
	]
})

export default router
