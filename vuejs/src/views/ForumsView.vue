<template>
	<div>
		<a-list item-layout="vertical" size="large" :pagination="pagination" :data-source="listData" :loading="loading">
			<template #renderItem="{ item }">
				<a-list-item key="item.title">
					<template #actions>
						<a-button @click="handleLike(item.id)">
							<LikeOutlined />
							{{ item.like_count }}
						</a-button>
						<a-button @click="goToPost(item.id)">
							<MessageOutlined />
							{{ item.replies_count }}
						</a-button>
					</template>
					<a-list-item-meta :description="getDateTimeString(item.updated_at)">
						<template #title>
							{{ item.username }}
						</template>
						<template #avatar>
							<a-avatar size="large">
								<template #icon>
									<UserOutlined />
								</template>
							</a-avatar>
						</template>
					</a-list-item-meta>
					<a class="post-content" @click="goToPost(item.id)">
						<h3>{{ item.title }}</h3>
						<div v-html="item.content"></div>
					</a>
					<a> # {{ item.company_name }}: {{ item.reason }} </a>
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
	name: 'ForumsView',
	components: {
		LikeOutlined,
		MessageOutlined,
		UserOutlined,
	},
	data() {
		return {
			loading: true,
			listData: [],
			pagination: {
				current: 1,
				total: 0,
				showSizeChanger: true,
				onChange: (page) => {
					this.pagination.current = page
				},
			},
		}
	},
	methods: {
		fetchData() {
			this.loading = true
			Api.forum.list().then((response) => {
				this.loading = false
				this.listData = response
				this.pagination.total = response.length
			})
		},
		getDateTimeString(timeStr) {
			return datetime.toDateTimeString(timeStr)
		},
		goToPost(id) {
			this.$router.push({ name: 'forums-post', params: { id } })
		},
		handleLike(id) {
			Api.forum.like(id).then(() => {
				this.fetchData()
			})
		},
	},
	mounted() {
		this.fetchData()
	},
}
</script>

<style scoped>
.ant-list-item-meta {
	margin-top: 12px;
}

:deep(.ant-list-item-meta-avatar) {
	margin-top: auto;
	margin-bottom: auto;
	margin-left: 8px;
	margin-right: 16px;
}

:deep(.ant-list-item-meta-title) {
	margin-top: 0;
	margin-block-end: 3px;
}

.post-content {
	color: black;
}

.post-content:hover {
	color: #69b1ff;
}

.post-content>h3 {
	font-weight: 600;
}

:deep(.ant-pagination) {
	padding-right: 16px;
	padding-bottom: 16px;
}
</style>
