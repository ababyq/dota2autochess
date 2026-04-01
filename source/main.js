import Vue from 'vue'
import App from './App'
import uView from "uview-ui";
Vue.use(uView);
Vue.config.productionTip = false
import request from "./common/http.js"
Vue.prototype.$http = request
App.mpType = 'app'

const app = new Vue({
    ...App
})
app.$mount()
