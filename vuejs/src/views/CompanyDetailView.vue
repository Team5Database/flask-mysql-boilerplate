<template>
	<div class="wrapper">
		<h1 class="title">{{ companyData.name }}</h1>
		<div class="meta">
			<div>Company Size: {{ companyData.company_size }}</div>
			<div>Created At: {{ getDateTimeString(companyData.created_at) }}</div>
			<div>Updated At: {{ getDateTimeString(companyData.updated_at) }}</div>
		</div>
	</div>
</template>

<script>
import { Api } from '@/api/api'
import datetime from '@/utils/datetime'

export default {
	name: 'CompanyDetailView',
	data() {
		return {
			companyData: {},
		}
	},
	methods: {
		fetchData() {
			Api.companies.get(this.$route.params.id).then((response) => {
				this.companyData = response[0]
				console.log(this.companyData)
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
.wrapper {
	padding: 64px 128px;
	padding-bottom: 0;
}

.wrapper h1 {
	font-size: 32px;
	font-weight: bold;
	margin: 0;
}

.wrapper .meta {
	margin-top: 16px;
	font-size: 16px;
}

.wrapper .meta>div {
	margin-bottom: 8px;
}

.wrapper .meta>div:last-child {
	margin-bottom: 0;
}
</style>
