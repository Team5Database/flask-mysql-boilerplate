import './assets/main.css'

import { createApp } from 'vue'
import App from './App.vue'
import router from './router'

const app = createApp(App)

app.use(router)

// Ant Design Vue: use iconfont
import IconFont from './components/IconFont.vue'
app.component('IconFont', IconFont)

app.mount('#app')
