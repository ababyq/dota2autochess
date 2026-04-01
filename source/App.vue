<script>
	export default {

		onLaunch: function() {
			console.log('App Launch')
			// wx.cloud.init({
			// 	env: 'autochess-save-8gexds2dfcb2c0ea',
			// 	traceUser: true
			// });
			// wx.getStorage({
			// 	key: "user",
			// 	success: function(res) {
			// 		if (!res.data) {
			// 			wx.cloud.callFunction({
			// 				name: 'getOpenId',
			// 				data: {},
			// 				success: res => {
			// 					wx.setStorage({
			// 						key: "user",
			// 						data: res.result.userInfo.openId
			// 					})
			// 				},
			// 				fail: err => {
			// 					console.error('获取失败：', err)
			// 				}
			// 			})
			// 		}
			// 	},
			// })


		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		}
	}
</script>

<style lang="scss">
	/* 注意要写在第一行，同时给style标签加入lang="scss"属性 */
	@import "uview-ui/index.scss";
	.uni-app--maxwidth {
		height: auto;
	}
</style>
