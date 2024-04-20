<template>
	<a-app>
		<div class="header">
			<img src="@/assets/logo.png" alt="logo" style="height: 30px" />
			<span class="title">Layoffs</span>
		</div>
		<div class="container">
			<a-menu style="width: 256px" mode="inline" v-model:openKeys="menu.openKeys"
				v-model:selectedKeys="menu.selectedKeys" :items="menu.items" :onClick="handleClick"></a-menu>
			<div class="wrapper">
				<div class="content">
					<router-view v-slot="{ Component }">
						<transition name="fade" mode="out-in">
							<component :is="Component" />
						</transition>
					</router-view>
				</div>
			</div>
		</div>
	</a-app>
</template>

<script>
import { h } from 'vue'
import { RouterView } from 'vue-router'
import IconFont from '@/components/IconFont.vue'

export default {
	name: 'App',
	components: {
		RouterView,
	},
	data() {
		return {
			menu: {
				openKeys: [],
				selectedKeys: [],
				items: [
					{
						key: '/layoffs',
						icon: () => h(IconFont, { type: 'icon-layoffs', style: { fontSize: '16px' } }),
						label: 'Layoffs',
						title: 'Layoffs',
					},
					{
						key: '/trends',
						icon: () => h(IconFont, { type: 'icon-trends', style: { fontSize: '16px' } }),
						label: 'Trends',
						title: 'Trends',
						children: [
							{
								key: '/trends/people',
								icon: () => h(IconFont, { type: 'icon-people', style: { fontSize: '16px' } }),
								label: 'People',
								title: 'People',
							},
							{
								key: '/trends/events',
								icon: () => h(IconFont, { type: 'icon-events', style: { fontSize: '16px' } }),
								label: 'Events',
								title: 'Events',
							}
						]
					},
					{
						key: '/companies',
						icon: () => h(IconFont, { type: 'icon-companies', style: { fontSize: '16px' } }),
						label: 'Companies',
						title: 'Companies',
					},
					{
						key: '/forums',
						icon: () => h(IconFont, { type: 'icon-forums', style: { fontSize: '16px' } }),
						label: 'Forums',
						title: 'Forums',
					},
					{
						key: '/resources',
						icon: () => h(IconFont, { type: 'icon-resources', style: { fontSize: '16px' } }),
						label: 'Resources',
						title: 'Resources',
					},
				],
			}
		}
	},
	methods: {
		handleClick(item) {
			this.$router.push(item.key)
		},
	},
	watch: {
		$route(to, from) {
			if (to.path.startsWith('/trends')) {
				this.menu.openKeys = ['/trends']
			} else {
				this.menu.openKeys = []
			}

			this.menu.selectedKeys = [to.path]
		}
	}
}
</script>

<style scoped>
.ant-app {
	display: flex;
	flex-direction: column;
	height: 100vh;
}

.header {
	display: flex;
	align-items: center;
	background-color: #001529;
	color: white;
	padding: 10px;
	padding-left: 21px;
	user-select: none;
}

.header>img {
	margin-right: 10px;
}

.header>.title {
	font-size: 1.5rem;
	font-family: HarmonyOS_Medium !important;
	font-weight: 600;
	letter-spacing: 1px;
}

.container {
	display: flex;
	flex: 1;
	overflow: auto;
}

.container>.ant-menu {
	font-size: 16px;
	user-select: none;
}

.container>.ant-menu :deep(.ant-menu-item) {
	height: 48px;
	line-height: 48px;
}

.container>.wrapper {
	background: #f4f5f7;
	flex: 1;
}

.content {
	height: calc(100% - 27px);
	margin: 27px 27px 0 27px;
	background: white;
	border-radius: 12px 12px 0 0;
	overflow: auto;
}

/* Router Transition */
.fade-enter-active,
.fade-leave-active {
	transition: all 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
	opacity: 0;
	transform: translateX(17px);
}
</style>
