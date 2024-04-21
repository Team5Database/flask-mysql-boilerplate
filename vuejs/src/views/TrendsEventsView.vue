<template>
	<div class="chart-container">
		<a-spin :spinning="loading">
			<v-chart class="chart" :option="option" autoresize />
		</a-spin>
	</div>
</template>

<script>
import { Api } from '@/api/api'

// echarts.js
import VChart from 'vue-echarts'
import { use } from 'echarts/core'
import { LineChart } from 'echarts/charts'
import { TitleComponent, GridComponent } from 'echarts/components'
import { CanvasRenderer } from 'echarts/renderers'

use([TitleComponent, GridComponent, LineChart, CanvasRenderer])

export default {
	name: 'TrendsEventsView',
	components: {
		VChart,
	},
	data() {
		return {
			loading: true,
			option: {
				title: {
					text: 'Trends of Layoffs by Events',
					left: 'center',
				},
				xAxis: {
					type: 'category',
					data: []
				},
				yAxis: {
					type: 'value'
				},
				series: [
					{
						data: [],
						type: 'line',
						smooth: true
					}
				]
			},
		}
	},
	methods: {
		fetchData() {
			this.loading = true
			Api.trends.get_by_events().then((response) => {
				this.loading = false
				this.option.xAxis.data = response.map((item) => `${item.year}-${item.month}`)
				this.option.series[0].data = response.map((item) => item.count)
			})
		},
	},
	mounted() {
		this.fetchData()
	},
}
</script>

<style scoped>
.chart-container {
	height: calc(100% - 64px);
	padding: 32px;
}

:deep(.ant-spin) {
	max-height: unset !important;
}

.ant-spin-nested-loading,
:deep(.ant-spin-container) {
	height: 100%;
}
</style>
