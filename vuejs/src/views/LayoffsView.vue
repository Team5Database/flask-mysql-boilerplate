<template>
	<div>
		<a-table :columns="columns" :row-key="record => record.id" :data-source="dataSource" :pagination="pagination"
			:loading="loading" @change="handleTableChange">
			<template #bodyCell="{ record, column, text }">
				<template v-if="column.dataIndex === 'company_name'">
					<a @click="goToCompany(record.company_id)">{{ text }}</a>
				</template>
				<template v-if="column.dataIndex === 'occurrence_at' || column.dataIndex === 'created_at' || column.dataIndex === 'updated_at'">
					{{ getDateTimeString(text) }}	
				</template>
			</template>
		</a-table>
	</div>
</template>

<script>
import { Api } from '@/api/api'
import datetime from '@/utils/datetime'

export default {
	name: 'LayoffsView',
	data() {
		return {
			loading: false,
			dataSource: [],
			pagination: {
				current: 1,
				pageSize: 10,
				total: 0,
			},
			columns: [
				{
					title: 'Company',
					dataIndex: 'company_name',
					key: 'company_name',
				},
				{
					title: 'Occurrence',
					dataIndex: 'occurrence_at',
					key: 'occurrence_at',
				},
				{
					title: 'Employee Count',
					dataIndex: 'employee_count',
					key: 'employee_count',
				},
				{
					title: 'Reason',
					dataIndex: 'reason',
					key: 'reason',
				},
				{
					title: 'Created At',
					dataIndex: 'created_at',
					key: 'created_at',
				},
				{
					title: 'Updated At',
					dataIndex: 'updated_at',
					key: 'updated_at',
				},
			],
		}
	},
	methods: {
		handleTableChange(pagination) {
			this.pagination = pagination
			this.fetchData()
		},
		getDateTimeString(timeStr) {
			return datetime.toDateTimeString(timeStr)
		},
		goToCompany(companyId) {
			this.$router.push({ name: 'company-detail', params: { id: companyId } })
		},
		fetchData() {
			this.loading = true
			Api.layoffs.list()
				.then(response => {
					this.loading = false
					this.dataSource = response
					this.pagination.total = response.length
				})
		},
	},
	mounted() {
		this.fetchData()
	},
}
</script>

<style scoped>
:deep(.ant-table-pagination) {
	padding-right: 16px;
}
</style>
