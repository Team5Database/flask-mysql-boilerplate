<template>
	<div>
		<a-list item-layout="vertical" size="large" :pagination="pagination" :data-source="listData" :loading="loading">
			<template #renderItem="{ item }">
				<a-list-item key="item.title">
					<a-list-item-meta :description="getDateTimeString(item.updated_at)">
						<template #title>
							<a @click="goToPost(item.id)">{{ item.title }}</a>
						</template>
					</a-list-item-meta>
					<a class="post-content" @click="goToPost(item.id)">
						<div v-html="item.content"></div>
					</a>
				</a-list-item>
			</template>
		</a-list>
	</div>
</template>

<script>
import { Api } from '@/api/api'
import datetime from '@/utils/datetime'
import { LikeOutlined, MessageOutlined, UserOutlined } from '@ant-design/icons-vue'

export default {
	name: 'ResourcesView',
	components: {
		LikeOutlined,
		MessageOutlined,
		UserOutlined,
	},
	data() {
		return {
			loading: false,
			listData: [],
			pagination: {
				current: 1,
				total: 0,
				onChange: (page) => {
					this.pagination.current = page
				},
			},
		}
	},
	methods: {
		fetchData() {
			this.loading = true
			Api.resources.list().then((response) => {
				this.loading = false
				this.listData = response
				this.pagination.total = response.length
			})
		},
		getDateTimeString(timeStr) {
			return datetime.toDateTimeString(timeStr)
		},
		goToPost(id) {
			this.$router.push({ name: 'resources-article', params: { id } })
		},
	},
	mounted() {
		this.fetchData()
	},
}
</script>

<style scoped>
:deep(.ant-list-item-meta-avatar) {
	margin-top: auto;
	margin-bottom: auto;
	margin-left: 8px;
	margin-right: 16px;
}

:deep(.ant-list-item-meta-title)>a {
	margin-top: 0;
	margin-block-end: 3px;
	font-weight: bold;
}

.post-content {
	color: black;
}

.post-content:hover {
	color: #69b1ff;
}

:deep(.ant-pagination) {
	padding-right: 16px;
	padding-bottom: 16px;
}
</style>
