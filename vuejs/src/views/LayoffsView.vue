<template>
	<div>
		<a-table :columns="columns" :row-key="record => record.login.uuid" :data-source="dataSource"
			:pagination="pagination" :loading="loading" @change="handleTableChange"></a-table>
	</div>
</template>

<script>
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
					title: 'Name',
					dataIndex: 'name',
					key: 'name',
					scopedSlots: { customRender: 'name' },
				},
				{
					title: 'Email',
					dataIndex: 'email',
					key: 'email',
				},
				{
					title: 'Phone',
					dataIndex: 'phone',
					key: 'phone',
				},
				{
					title: 'Location',
					dataIndex: 'location',
					key: 'location',
				},
				{
					title: 'Date',
					dataIndex: 'date',
					key: 'date',
				},
				{
					title: 'Action',
					key: 'action',
					scopedSlots: { customRender: 'action' },
				},
			],
		}
	},
	methods: {
		handleTableChange(pagination) {
			this.pagination = pagination
			this.fetchData()
		},
		fetchData() {
			this.loading = true
			const { current, pageSize } = this.pagination
			const url = `https://randomuser.me/api?results=${pageSize}&page=${current}`
			fetch(url)
				.then(response => response.json())
				.then(data => {
					this.loading = false
					this.pagination.total = 200
					this.dataSource = data.results
				})
				.catch(error => {
					this.loading = false
					console.error('Fetch data error:', error)
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
