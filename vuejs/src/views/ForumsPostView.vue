<template>
	<div>
		<div class="header">
			<a-avatar :size="48">
				<template #icon>
					<UserOutlined />
				</template>
			</a-avatar>
			<div class="meta">
				<span class="username">
					{{ itemData.username }}
				</span>
				<br>
				{{ getDateTimeString(itemData.updated_at) }}
			</div>
		</div>
		<div class="content">
			<h3>{{ itemData.title }}</h3>
			<div v-html="itemData.content"></div>
		</div>
		<div class="reply">
			<a-comment>
				<template #avatar>
					<a-avatar :size="32">
						<template #icon>
							<UserOutlined />
						</template>
					</a-avatar>
				</template>
				<template #content>
					<a-form-item>
						<a-textarea v-model:value="comment" :rows="4" />
					</a-form-item>
					<a-form-item class="reply-button">
						<a-button html-type="submit" :loading="submitting" type="primary" @click="handleReply">
							Reply
						</a-button>
					</a-form-item>
				</template>
			</a-comment>
			<a-list class="comment-list" :header="`${replies.length} replies`" item-layout="horizontal"
				:data-source="replies">
				<template #renderItem="{ item }">
					<a-list-item>
						<a-comment :author="item.username">
							<template #avatar>
								<a-avatar :size="32">
									<template #icon>
										<UserOutlined />
									</template>
								</a-avatar>
							</template>
							<template #actions>
								<span>
									<a @click="handleLike(item.id)">
										<LikeOutlined />
										{{ item.like_count }}
									</a>
								</span>
								<span>
									<a @click="handleDelete(item.id)">
										<DeleteOutlined />
									</a>
								</span>
							</template>
							<template #content>
								<p v-html="item.content"></p>
							</template>
							<template #datetime>
								<a-tooltip :title="getDateTimeString(item.updated_at)">
									<span>{{ getDateFromNow(item.updated_at) }}</span>
								</a-tooltip>
							</template>
						</a-comment>
					</a-list-item>
				</template>
			</a-list>
		</div>
	</div>
</template>

<script>
import { Api } from '@/api/api'
import datetime from '@/utils/datetime'
import { UserOutlined, LikeOutlined, DeleteOutlined } from '@ant-design/icons-vue'

export default {
	name: 'ForumsPostView',
	components: {
		UserOutlined,
		LikeOutlined,
		DeleteOutlined,
	},
	data() {
		return {
			itemData: {},
			replies: [],
			comment: '',
			submitting: false,
		}
	},
	methods: {
		fetchData() {
			Api.forum.get(this.$route.params.id).then((response) => {
				this.itemData = response[0]
			})
			Api.forum.replies.get(this.$route.params.id).then((response) => {
				this.replies = response
			})
		},
		getDateTimeString(timeStr) {
			return datetime.toDateTimeString(timeStr)
		},
		getDateFromNow(timeStr) {
			return datetime.fromNow(timeStr)
		},
		handleReply() {
			this.submitting = true
			Api.forum.replies.post(this.$route.params.id, this.comment).then(() => {
				this.submitting = false
				this.comment = ''
				this.fetchData()
			})
		},
		handleLike(id) {
			Api.forum.like(id).then(() => {
				this.fetchData()
			})
		},
		handleDelete(id) {
			Api.forum.delete(id).then(() => {
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
.header {
	display: flex;
	padding: 64px;
	padding-bottom: 0;
}

.header>.meta {
	padding-left: 16px;
}

.header>.meta>.username {
	font-size: 16px;
	font-weight: bold;
	padding-bottom: 4px;
}

.content {
	padding: 32px 81px;
}

.content>h3 {
	font-size: 16px;
	font-weight: bold;
}

.reply {
	padding: 32px 81px;
}

.reply-button {
	display: flex;
	flex-direction: row-reverse;
}
</style>
