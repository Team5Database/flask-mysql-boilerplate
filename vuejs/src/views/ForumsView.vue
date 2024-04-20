<template>
	<div>
		<a-list item-layout="vertical" size="large" :pagination="pagination" :data-source="listData">
			<template #renderItem="{ item }">
				<a-list-item key="item.title">
					<template #actions>
						<span v-for="{ icon, text } in actions" :key="icon">
							<component :is="icon" style="margin-right: 8px" />
							{{ text }}
						</span>
					</template>
					<a-list-item-meta :description="item.description">
						<template #title>
							<a :href="item.href">{{ item.title }}</a>
						</template>
						<template #avatar><UserOutlined /></template>
					</a-list-item-meta>
					{{ item.content }}
				</a-list-item>
			</template>
		</a-list>
	</div>
</template>

<script>
import { StarOutlined, LikeOutlined, MessageOutlined, UserOutlined } from '@ant-design/icons-vue'

export default {
	name: 'ForumsView',
	components: {
		StarOutlined,
		LikeOutlined,
		MessageOutlined,
		UserOutlined,
	},
	data() {
		return {
			actions: [
				{ icon: 'StarOutlined', text: '156' },
				{ icon: 'LikeOutlined', text: '156' },
				{ icon: 'MessageOutlined', text: '2' },
			],
			listData: [],
			pagination: {
				current: 1,
				pageSize: 4,
				total: 23,
				onChange: (page) => {
					console.log(page)
					this.pagination.current = page
				},
			},
		}
	},
	mounted() {
		this.fetchData()
	},
	methods: {
		fetchData() {
			for (let i = 0; i < 23; i++) {
				this.listData.push({
					href: 'https://www.antdv.com/',
					title: `ant design vue part ${i}`,
					description:
						'Ant Design, a design language for background applications, is refined by Ant UED Team.',
					content:
						'We supply a series of design principles, practical patterns and high quality design resources (Sketch and Axure), to help people create their product prototypes beautifully and efficiently.',
				});
			}
		}
	}
}
</script>

<style scoped>
:deep(.ant-list-item-meta-avatar) {
	margin-top: auto;
    margin-bottom: auto;
	margin-left: 8px;
	margin-right: 16px;
}

:deep(.ant-pagination) {
	padding-right: 16px;
	padding-bottom: 16px;
}
</style>
