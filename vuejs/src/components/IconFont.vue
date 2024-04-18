<template>
    <IconFont :type="type" :style="style" />
</template>

<script>
import { defineComponent } from 'vue'
import { createFromIconfontCN } from '@ant-design/icons-vue'

export default defineComponent({
    name: 'Iconfont',
    props: {
        type: {
            required: true,
        },
        style: {
            type: Object,
            default: () => ({}),
        },
    },
    components: {
        IconFont: createFromIconfontCN({
            scriptUrl: '//at.alicdn.com/t/c/font_4513514_xluv4nvpfkg.js',
        })
    },
})
</script>
