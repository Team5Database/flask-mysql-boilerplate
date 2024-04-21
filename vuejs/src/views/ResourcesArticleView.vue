<template>
	<div>
		<div class="content">
			<div class="header">
				<h1>{{ itemData.title }}</h1>
				<span class="meta">
					{{ getDateTimeString(itemData.updated_at) }}
				</span>
			</div>
			<div v-html="itemData.content"></div>
		</div>
	</div>
</template>

<script>
import { Api } from '@/api/api'
import datetime from '@/utils/datetime'
import { UserOutlined, LikeOutlined } from '@ant-design/icons-vue'

export default {
	name: 'ResourcesArticleView',
	components: {
		UserOutlined,
		LikeOutlined,
	},
	data() {
		return {
			itemData: {},
		}
	},
	methods: {
		fetchData() {
			Api.resources.get(this.$route.params.id).then((response) => {
				this.itemData = response[0]
			})
		},
		getDateTimeString(timeStr) {
			return datetime.toDateTimeString(timeStr)
		},
	},
	mounted() {
		this.fetchData()
	},
}
</script>

<style scoped>
.content {
	padding: 81px;
	padding-bottom: 0;
	font-size: 16px;
}

.header {
	display: flex;
	justify-content: space-between;
    align-items: center;
    margin-bottom: 32px;
}

.header h1 {
	font-size: 32px;
	font-weight: bold;
	margin: 0;
}

.header .meta {
	font-size: 16px;
	color: #999;
}
</style>
