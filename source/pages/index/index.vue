<template>
	<view class="main" :class="{ 'dark-mode': darkMode }">
		<view class="tabs-fixed">
			<view class="tabs-wrapper">
				<u-tabs :list="list" :current="active" active-color="#1890ff" inactive-color="#666" @change="change"
					:is-scroll="false">
				</u-tabs>
			</view>
			<view @click="toggleDarkMode" class="theme-toggle-global">
				<image :src="darkMode ? '/static/sun.png' : '/static/moon.png'"
					style="width: 40rpx; height: 40rpx;" mode="aspectFit" />
			</view>
		</view>

		<view style="padding-bottom: 360rpx;">
			<view class="chooseCard"
				style="position: fixed; bottom: 50rpx; left: 0; right: 0; z-index: 10000; margin: 20rpx;border-radius: 30rpx;"
				v-show="active !== 6">
				<!-- 列表模式（原有） -->
				<view class="fettercard" v-if="choosePool.length>0 && fetterViewMode === 'list' && choosefetters.some(f => f.isActive)">
					<view>
						<view v-show="fetterHidden">
							<view class="fetter" v-for="(fetter, fIndex) in choosefetters.filter(f => f.isActive)" :key="fIndex">
								<view class="fetterSummary">
									<text class="fetterName"
										:style="'background:'+(majors.filter(i=>i.id==fetter.fetter.majorId)[0] ? majors.filter(i=>i.id==fetter.fetter.majorId)[0].color : '#ccc')">
										{{fetter.fetter.name}}
									</text>
								</view>
								<view class="fetterDetail">
									<view class="fetters"
										:style="'color:'+(majors.filter(i=>i.id==fetter.fetter.majorId)[0] ? majors.filter(i=>i.id==fetter.fetter.majorId)[0].color : 'violet')"
										v-for="(f, fIdx) in fetter.fetters" :key="fIdx">{{'('+f.condition+')'+f.desc}}
									</view>
									<view class="fetterChesses" v-if="fetter.chesses && fetter.chesses.length > 0">
										<view class="fetterChess" v-for="(chess, cIdx) in fetter.chesses" :key="cIdx">
											<image :src="chess.isWheelBonus ? '/static/items/item_custom/rm_wheel_of_wonder.png' : chess.photo" style="width: 28rpx;height: 28rpx;" alt=""
												v-if="chess && (chess.photo || chess.isWheelBonus)" />
											<text v-if="chess && chess.name">{{chess.isWheelBonus ? '奇观轮' : chess.name}}</text>
										</view>
									</view>
								</view>
							</view>
						</view>
						<view v-show="!fetterHidden">
							<view class="fetterlite">
								<text :style="'background:'+majors.filter(i=>i.id==fetter.fetter.majorId)[0].color"
									class="fetterName" v-for="fetter in choosefetters.filter(f => f.isActive)">{{fetter.fetter.name}}</text>
							</view>
						</view>
						<view class="fetterarrow" @click="accordion()">
							<u-icon size="24" :name="fetterHidden?'arrow-down':'arrow-up'" />
						</view>
					</view>
				</view>

				<!-- 方块格子模式（新增） -->
				<view class="fettercard fettercard-tile" v-if="choosePool.length>0 && fetterViewMode === 'tile'">
					<scroll-view class="fetterlite-scroll" scroll-x="true" :show-scrollbar="false">
						<view class="fetterlite fetterlite-tile">
							<view class="fetter-tile" v-for="(fetter, fIndex) in choosefetters" :key="fIndex">
								<!-- 格子网格 - 按层级分行，从下往上排列（图标上方） -->
								<view class="fetter-tile-grid">
									<view class="fetter-tile-row" v-for="(row, rowIdx) in fetter.levelRows" :key="rowIdx"
										v-if="!row.isEmpty">
										<view class="fetter-tile-slot"
											v-for="(slot, sIdx) in row.slots" :key="sIdx"
											:class="{'slot-active': slot.isActive, 'slot-highlight': slot.isHighlight, 'slot-partial': slot.isPartial}"
											:style="slot.isActive ? 'background:'+fetter.majorColor : (slot.isPartial ? 'background:rgba(128,128,128,0.9)' : 'background:rgba(128,128,128,0.3)')">
										</view>
									</view>
								</view>
								<!-- 图标在下方 -->
								<view class="fetter-tile-info" @click="showFetterChessDetail(fetter)">
									<image :src="'/static/majors/'+fetter.majorPhoto" class="fetter-tile-icon"
										:class="{'fetter-icon-inactive': !fetter.isActive && fetter.chessCount > 0}"
										v-if="fetter.majorPhoto" />
								</view>
							</view>
						</view>
					</scroll-view>
				</view>

				<view class="menuRagne">
					<view @click="removeRepeatchess()" class="chooseItem show u-button" style="margin-right: 25rpx;">
						<text v-if="choosePool.length<16" style="color: #fff;">{{choosePool.length}}</text>
						<text v-else style="color: #FFD01E;">{{choosePool.length}}</text>
					</view>
					<!-- 羁绊视图切换按钮 -->
					<view @click="toggleFetterView()" class="u-button chooseItem fetter-change"
						v-if="choosePool.length > 0">
						<u-icon :name="fetterViewMode==='tile' ? 'list' : 'grid'" bold color="#fff" />
					</view>
					<view @click="tips()" class="u-button chooseItem tips">
						<u-icon name="question" bold color="#fff" />
					</view>
					<view @click="getMySaves()" v-if='false' class="u-button chooseItem action">
						<u-icon name="star" bold />
					</view>
					<!-- 百戏大王按钮 -->
					<view @click="showRingmasterDetail()" class="u-button chooseItem ringmaster-btn"
						v-if="ringmasterChess">
						<image :src="ringmasterChess.photo" style="width: 40rpx; height: 40rpx; border-radius: 8rpx;"
							mode="aspectFit" />
					</view>
					<!-- 奇观轮按钮 -->
					<view @click="showWheelSelect()" class="u-button chooseItem rm_wheel" >
						<u--image src="/static/items/item_custom/rm_wheel_of_wonder.png" width="40rpx" height="40rpx" shape="circle" mode="aspectFill" />
					</view>
					<!-- 重复模式开关 -->
					<view @click="toggleRepeatMode()" class="u-button chooseItem repeat-mode-btn"
						:class="{'active': repeatMode}">
						<u-icon name="reload" bold :color="repeatMode ? '#FFD700' : '#fff'" size="20" />
					</view>
					<view @click="clearChessPool()" class="u-button chooseItem action" style="float: right;margin-left:35rpx;">
						<u-icon name="trash" bold color="#fff" />
					</view>
				</view>
				<view class="chooseRagne" v-if="choosePool.length>0 || selectedWheelFetters.length>0">
					<view @click="removeChess(chess,index)" v-for="(chess,index) in choosePool"
						class="chooseItem choosebg" :key="index">
						<image style="width: 64rpx;height: 64rpx;" :src="chess.photo" alt="" />
					</view>
					<!-- 奇观轮已选羁绊展示 -->
					<view v-for="(fetter, index) in selectedWheelFetters" :key="'wheel-'+index"
						class="chooseItem wheel-fetter-item" @click="removeWheelFetter(index)">
						<image :src="fetter.photo" style="width: 64rpx; height: 64rpx;" mode="aspectFit" />
						<image class="wheel-badge" src="/static/items/item_custom/rm_wheel_of_wonder.png" mode="aspectFit" />
					</view>
				</view>

			</view>
			<view v-show="active==0" class="card">
				<view class="container">
					<view v-for="(costChess,index) in costChesses" class="chesslevel" :key="index" v-if="costChess">
						<view class="chess-base chesslineCost" :name="costChess.cost"
							:style="'background:'+level[costChess.cost]+';box-shadow: 0 0 0 10rpx '+level[costChess.cost]+'50;'">
							<text>{{index+1}}</text>
						</view>
						<view class="raocchesses" v-if="costChess.chesses && costChess.chesses.length > 0">
							<view v-for="(chess, cIndex) in costChess.chesses" :key="cIndex"
								class="chess-base chessline" :name="chess.name"
								:style="'background:'+level[costChess.cost]+';box-shadow: 0 0 0 10rpx '+level[chess.cost]+'50;'"
								@click="showChessDetail(chess)" v-if="chess">
								<image style="width: 64rpx;height: 64rpx;" :src="chess.photo" alt=""
									v-if="chess.photo" />
							</view>
						</view>
					</view>
				</view>
				<!-- 小黑屋 - 未启用的棋子 -->
				<view class="blackhouse" v-if="disabledChesses.length > 0">
					<view class="blackhouse-title">
						<text class="blackhouse-text">小黑屋</text>
						<text class="blackhouse-sub">(未启用)</text>
					</view>
					<view class="blackhouse-list">
						<view v-for="(chess, cIndex) in disabledChesses" :key="cIndex" class="blackhouse-item"
							:name="chess.name" @click="showChessDetail(chess)" v-if="chess">
							<image style="width: 64rpx;height: 64rpx;" :src="chess.photo" alt="" v-if="chess.photo" />
							<text class="blackhouse-name">{{chess.name}}</text>
						</view>
					</view>
				</view>
			</view>
			<view v-show="active==1" class="card">
				<view class="container">
					<view v-for="(rachess, rIndex) in raChesses" :key="rIndex" class="chessraoc"
						v-if="rachess && rachess.ra">
						<view class="chess-base chesslineRaOc" :name="rachess.ra.name"
							@click="chooseRaocChesses(rachess)" v-if="rachess.ra">
							<image style="width: 64rpx;height: 64rpx;" :src="rachess.ra.photo" alt=""
								v-if="rachess.ra.photo" />
						</view>
						<view class="raocchesses" v-if="rachess.chesses && rachess.chesses.length > 0">
							<view v-for="(chess, cIndex) in rachess.chesses" :key="cIndex" class="chess-base chessline"
								:name="chess.name" :style="'box-shadow: 0 0 0 10rpx '+level[chess.cost]+'50;'"
								@click="chooseChess(chess)" v-if="chess">
								<image style="width: 64rpx;height: 64rpx;" mode="aspectFill" :src="chess.photo" alt=""
									v-if="chess.photo" />
							</view>
						</view>
					</view>
				</view>
			</view>

			<view v-show="active==2" class="card">
				<view class="container">
					<view v-for="(occchess, oIndex) in occChesses" :key="oIndex" class="chessraoc"
						v-if="occchess && occchess.occ">
						<view class="chess-base chesslineRaOc" :name="occchess.occ.name"
							@click="chooseRaocChesses(occchess)" v-if="occchess.occ">
							<image style="width: 64rpx;height: 64rpx;" :src="occchess.occ.photo" alt=""
								v-if="occchess.occ.photo" />
						</view>
						<view class="raocchesses" v-if="occchess.chesses && occchess.chesses.length > 0">
							<view v-for="(chess, cIndex) in occchess.chesses" :key="cIndex" class="chess-base chessline"
								:name="chess.name" :style="'box-shadow: 0 0 0 10rpx '+level[chess.cost]+'50;'"
								@click="chooseChess(chess)" v-if="chess">
								<image style="width: 64rpx;height: 64rpx;" :src="chess.photo" alt=""
									v-if="chess.photo" />
							</view>
						</view>
					</view>
				</view>
			</view>

			<view v-show="active==3" class="card">
				<view class="table-header">
				</view>
				<view class="table-wrapper" :class="{'fullscreen-mode': fullscreen}">
					<view class="table-container" id="table">
						<view v-for="(row,index) in raocTale" class="chesstable" :key="index" v-if="row">
							<view class="tablecell" v-for="(cell,c) in row" :key="c" @click="chooseCell(cell)"
								v-if="cell && cell.chesses"
								:class="{'fixed-col': c===0, 'fixed-row': index===0, 'selected-cell': isCellSelected(cell) && !(cell.count > 1 && index > 0 && c > 0), 'multi-cell-selected': cell.count > 1 && index > 0 && c > 0 && isCellPartialSelected(cell)}">
								<view v-if="cell.count > 1 && index > 0 && c > 0" class="multi-chess-grid">
									<image v-for="(chess, ci) in cell.chesses.slice(0, 4)" :key="ci"
										v-if="chess && chess.photo" :src="chess.photo" class="grid-chess"
										:class="{'grid-chess-selected': choosePool.some(c => c.id === chess.id)}" />
									<text v-if="cell.count > 4" class="grid-more">+{{cell.count - 4}}</text>
								</view>
								<view v-else-if="cell.chesses[0]" class="single-chess">
									<image v-if="cell.chesses[0].photo" :src="cell.chesses[0].photo"
										class="cell-main-chess" />
								</view>
							</view>
						</view>
					</view>
				</view>
			</view>

			<!-- 装备tab -->
			<view v-show="active==4" class="card">
				<view class="items-container">
					<view class="item-card" v-for="(item, index) in items" :key="index" v-if="item">
						<image :src="item.photo" class="item-icon" mode="aspectFit" v-if="item.photo" />
						<view class="item-info">
							<view class="item-header">
								<text class="item-name">{{item.name}}</text>
								<text class="item-level" :class="'level-'+item.level">{{item.level}}级</text>
							</view>
							<text class="item-desc">{{item.desc}}</text>
						</view>
					</view>
				</view>
			</view>

			<!-- 圣物tab -->
			<view v-show="active==5" class="card">
				<view class="relics-container">
					<view class="relic-card" v-for="(relic, index) in relics" :key="index" v-if="relic">
						<image :src="relic.photo" class="relic-icon" mode="aspectFit" v-if="relic.photo" />
						<view class="relic-info">
							<text class="relic-name">{{relic.name}}</text>
							<text class="relic-desc">{{relic.desc}}</text>
						</view>
					</view>
				</view>
			</view>

			<!-- 熊猫模拟tab -->
		<view v-show="active==6" class="card panda-card">
			<view class="panda-header">
				<view class="round-info">第 {{pandaState.currentRound}} / 50 回合</view>
				<view class="panda-controls">
					<u-button size="mini" :type="pandaState.immortalMode > 0 ? 'warning' : 'default'" @click="toggleImmortalMode">
						<text>{{getImmortalName()}}</text>
					</u-button>
					<u-button size="mini" class="help-btn" @click="showPandaHelp">
						<text>规则</text>
					</u-button>
					<u-button size="mini" class="reset-btn" @click="resetPandaSim">
						<text>重置</text>
					</u-button>
				</view>
			</view>
			
			<!-- 主内容区：响应式布局容器 -->
			<view class="panda-main-content">
				<!-- 左列：棋盘、等待区、背包 -->
				<view class="panda-left-column">
					<view class="board-area">
						<view class="board-header">
							<view class="board-title">场上 (棋盘)</view>
							<view class="board-btn" v-if="pandaState.boardPandas.filter(p => p).length > 0" @click="arrangeBoard">
								整理
							</view>
						</view>
						<view class="board-card">
							<view class="board-slots">
								<view class="board-slot" :class="(Math.floor(idx / 8) + idx % 8) % 2 === 0 ? 'cell-white' : 'cell-black'" v-for="(slot, idx) in 32" :key="'board'+idx">
									<view v-if="pandaState.boardPandas[idx]" class="panda-piece"
										:class="'star-'+pandaState.boardPandas[idx].star" @click="pandaState.isFinished ? null : showPandaMenu(idx, 'board')">
										<image :src="'/static/mini/' + pandaState.boardPandas[idx].image" mode="aspectFit">
										</image>
										<view v-if="pandaState.boardPandas[idx].hasCharm" class="charm-badge"><image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit" class="charm-img"></image></view>
										<text class="piece-star">{{ '★'.repeat(pandaState.boardPandas[idx].star) }}</text>
									</view>
								</view>
							</view>
						</view>
					</view>

					<view class="bench-area">
						<view class="bench-header">
							<view class="bench-title">场下 (等待区)</view>
							<view class="bench-btns">
								<view class="bench-in-btn" v-if="pandaState.benchPandas.filter(p => p).length > 0" @click="moveAllToBoard">
									全部上场
								</view>
							</view>
						</view>
						<view class="bench-card">
							<view class="bench-slots">
								<view class="bench-slot" v-for="(slot, idx) in 8" :key="'bench'+idx">
									<view v-if="pandaState.benchPandas[idx]" class="panda-piece small"
										:class="'star-'+pandaState.benchPandas[idx].star"
										@click="pandaState.isFinished ? null : showPandaMenu(idx, 'bench')">
										<image :src="'/static/mini/' + pandaState.benchPandas[idx].image" mode="aspectFit">
										</image>
										<view v-if="pandaState.benchPandas[idx].hasCharm" class="charm-badge-mini"><image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit" class="charm-img-mini"></image></view>
										<text class="piece-star-mini">{{ '★'.repeat(pandaState.benchPandas[idx].star) }}</text>
									</view>
								</view>
							</view>
						</view>
					</view>

					<view class="backpack-area">
						<view class="backpack-title">背包 ({{pandaState.backpackCharms}}/6)</view>
						<view class="backpack-charms">
							<view class="backpack-charm" v-for="i in pandaState.backpackCharms" :key="'bp'+i"
								@click="pandaState.isFinished ? null : assignBackpackCharm()">
								<image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit"></image>
							</view>
							<view class="backpack-charm empty" v-for="i in (6 - pandaState.backpackCharms)" :key="'bpe'+i">
							</view>
						</view>
					</view>
				</view>
				
				<!-- 右列：日志 -->
				<view class="panda-right-column">
					<view class="panda-status">
						<view class="status-title-row">
							<text class="status-title">日志</text>
							<view class="log-filter-dots">
								<view class="filter-dot info" :class="{active: pandaState.logFilters && pandaState.logFilters.info}" @click="toggleLogFilter('info')"></view>
								<view class="filter-dot error" :class="{active: pandaState.logFilters && pandaState.logFilters.error}" @click="toggleLogFilter('error')"></view>
								<view class="filter-dot combine" :class="{active: pandaState.logFilters && pandaState.logFilters.combine}" @click="toggleLogFilter('combine')"></view>
								<view class="filter-dot charm" :class="{active: pandaState.logFilters && pandaState.logFilters.charm}" @click="toggleLogFilter('charm')"></view>
								<view class="filter-dot sell" :class="{active: pandaState.logFilters && pandaState.logFilters.sell}" @click="toggleLogFilter('sell')"></view>
							</view>
						</view>

						<view class="status-row panda-counts">
							<view class="panda-count-item" v-for="(count, id) in pandaState.pandaStats" :key="id">
								<view class="" >
									<image :src="'/static/mini/' + getPandaImage(id)" class="panda-icon"></image>
									✕
									<text class="count-num">{{count.dropped}}</text>
								</view>
								<text class="drop-rate">{{getPandaDropRates()[id] || '0%'}}</text>
							</view>
						</view>
						<view class="status-current">{{pandaState.statusText}}</view>
						<scroll-view scroll-y :show-scrollbar="true" class="status-scroll">
							<view v-if="pandaState.statusLogs.length === 0" class="status-log-empty">Good Luck!</view>
							<view class="status-log" v-for="(log, idx) in getFilteredLogs()" :key="idx"
								:class="{'log-error': log.type === 'error', 'log-charm': log.type === 'charm', 'log-combine': log.type === 'combine', 'log-sell': log.type === 'sell'}">
								• {{log.text}}
							</view>
						</scroll-view>

					</view>
				</view>
			</view>

			<!-- 底部固定按钮 -->
			<view class="panda-footer">
				<u-button type="primary" shape='circle' :disabled="pandaState.isFinished" @click="togglePandaRun">
					{{pandaState.isFinished ? '已结束' : (pandaState.currentRound === 1 && !pandaState.initialPandaPlaced ? '开始' : '继续')}}
				</u-button>
			</view>
		</view>

			<!-- 抽到熊猫弹窗 -->
				<view v-if="pandaState.showPandaPopup" class="panda-popup-overlay">
					<view class="panda-popup">
						<view class="popup-title"
							:class="pandaState.caughtPandaSource === '抽卡' ? 'source-card' : 'source-drop'">
							{{pandaState.caughtPandaSource === '抽卡' ? '抽卡获得!' : '掉落获得!'}}
						</view>
						<view class="popup-panda">
							<image :src="'/static/mini/' + pandaState.caughtPanda.image" mode="aspectFit"></image>
						</view>
						<view class="popup-name">{{pandaState.caughtPanda.name}}</view>
						<view class="popup-dialog">{{pandaState.caughtPanda.dialog}}</view>
						<view class="popup-btns">
							<u-button type="primary" @click="placePanda('board')">
								<text>上场</text>
							</u-button>
							<u-button @click="placePanda('bench')">
								<text>场下</text>
							</u-button>
						</view>
					</view>
				</view>

				<!-- 熊猫掉落弹窗 -->
				<view v-if="pandaState.showDropPopup && pandaState.droppedPandasList.length > 0" class="panda-popup-overlay" @click="closeDropPopup">
					<view class="panda-popup drop-popup" @click.stop>
						<view class="popup-title">熊猫掉落! ({{pandaState.droppedPandasList.length}}只)</view>
						<view class="dropped-pandas">
							<view class="dropped-panda" v-for="(panda, idx) in pandaState.droppedPandasList"
								:key="'dp'+idx">
								<image :src="'/static/mini/' + panda.image" mode="aspectFit"></image>
								<text class="dropped-star">{{ '★'.repeat(panda.star) }}</text>
								<text class="dropped-name">{{panda.name}}</text>
								<text class="dropped-dialog">{{panda.dialog}}</text>
							</view>
						</view>
						<view class="popup-btns">
							<u-button type="primary" @click="closeDropPopup">
								<text>确认</text>
							</u-button>
						</view>
					</view>
				</view>

			<!-- 护符分配弹窗 -->
			<view v-if="pandaState.showCharmPopup" class="panda-popup-overlay" @click="closeCharmPopup">
				<view class="panda-popup" @click.stop>
					<view class="popup-title">{{pandaState.assigningFromBackpack ? '分配幸运挂坠' : '获得幸运挂坠!'}}</view>
					<view class="popup-charm"><image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit" class="charm-img"></image></view>
					
					<view class="charm-options">
						<view class="charm-option-group">
							<view class="option-title">场上熊猫</view>
							<view class="charm-select">
								<view v-for="(panda, idx) in pandaState.boardPandas.filter(p => p)" :key="'charmb'+idx"
									class="charm-option" :class="{
									'selected': pandaState.selectedCharmPanda === panda,
									'disabled': panda.hasCharm
								}" @click="!panda.hasCharm && assignCharm(panda)">
									<image :src="'/static/mini/' + panda.image" mode="aspectFit"></image>
									<text class="charm-star">{{ '★'.repeat(panda.star) }}</text>
									<view v-if="panda.hasCharm" class="charm-badge-icon"><image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit" class="charm-img"></image></view>
								</view>
								<text v-if="pandaState.boardPandas.filter(p => p).length === 0" class="no-panda">暂无熊猫</text>
							</view>
						</view>
						
						<view class="charm-option-group">
							<view class="option-title">场下熊猫</view>
							<view class="charm-select">
								<view v-for="(panda, idx) in pandaState.benchPandas.filter(p => p)" :key="'charme'+idx"
									class="charm-option" :class="{
									'selected': pandaState.selectedCharmPanda === panda,
									'disabled': panda.hasCharm
								}" @click="!panda.hasCharm && assignCharm(panda)">
									<image :src="'/static/mini/' + panda.image" mode="aspectFit"></image>
									<text class="charm-star">{{ '★'.repeat(panda.star) }}</text>
									<view v-if="panda.hasCharm" class="charm-badge-icon"><image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit" class="charm-img"></image></view>
								</view>
								<text v-if="pandaState.benchPandas.filter(p => p).length === 0" class="no-panda">暂无熊猫</text>
							</view>
						</view>
					</view>
					
					<view class="popup-btns">
						<u-button type="primary" @click="storeCharmToBackpack">
							<text>存入背包</text>
						</u-button>
						<u-button @click="closeCharmPopup">
							<text>关闭</text>
						</u-button>
					</view>
				</view>
			</view>

			<!-- 没钓到熊猫弹窗 -->
				<view v-if="pandaState.showNoPandaPopup" class="panda-popup-overlay">
					<view class="panda-popup small">
						<view class="popup-title">本回合没钓到</view>
						<view class="popup-btns">
							<u-button type="primary" @click="closeNoPandaPopup">
								<text>继续</text>
							</u-button>
						</view>
					</view>
				</view>

				<!-- 规则说明弹窗 -->
				<view v-if="pandaState.showHelpPopup" class="panda-popup-overlay" @click="closeHelpPopup">
					<view class="panda-popup help-popup" @click.stop>
						<view class="help-title">钓鱼说明</view>
						<view class="help-content">
							<view class="help-section">
								<view class="help-section-title">掉落概率</view>
								<view class="help-text">• 1种熊猫人：10%概率掉落不在场的熊猫人</view>
								<view class="help-text">• 2种+熊猫人：效果1 + 效果2同时生效</view>
								<view class="help-text">  - 效果1：10%概率掉落不在场的熊猫人</view>
								<view class="help-text">  - 效果2：每只熊猫15%概率掉落同名熊猫人</view>
								<view class="help-text">  - 算法根据刀塔自走棋源码移植，去掉了其他种族掉落</view>
							</view>
							<view class="help-section">
								<view class="help-section-title">挂坠效果 <image src="/static/items/item_custom/item_slark_fish_bait.png" style="width: 30rpx; height: 30rpx;" mode="aspectFit"></image></view>
								<view class="help-text">• 效果1：整体概率提升，熊猫越多效果越弱</view>
								<view class="help-text">  公式：(熊猫数 + 挂坠数×0.25) / 熊猫数</view>
								<view class="help-text">  1熊猫+1挂坠=1.25倍，2熊猫+1挂坠=1.125倍</view>
								<view class="help-text">• 效果2：每个熊猫独立计算</view>
								<view class="help-text">  有挂坠：15% × 1.25 = 18.75%</view>
								<view class="help-text">  无挂坠：15% × 1.0 = 15%</view>
								<view class="help-text">  同种熊猫概率 = 熊猫数量 × 单个概率</view>
							</view>
							<view class="help-section">
								<view class="help-section-title">防非机制</view>
								<view class="help-text">• 初始为基础概率的68.3%</view>
								<view class="help-text">• 只有效果1没触发时才增加防非值</view>
								<view class="help-text">• 每次未触发概率×1.1（提升10%）</view>
								<view class="help-text">• 效果1成功掉落后重置</view>
							</view>
							<view class="help-section">
								<view class="help-section-title">修仙模式</view>
								<view class="help-text">• 点击切换境界，每次+0.1倍概率</view>
								<view class="help-text">• 炼气1.1x ~ 道祖2.3x</view>
							</view>
							<view class="help-section">
								<view class="help-section-title">物品回合</view>
								<view class="help-text">• 1, 2, 10, 15, 20, 25, 30, 35, 40, 45, 50回合</view>
							</view>
						</view>
					</view>
				</view>

				<!-- 重置确认弹窗 -->
				<view v-if="pandaState.showResetConfirmPopup" class="panda-popup-overlay" @click="closeResetConfirmPopup">
					<view class="panda-popup reset-popup" @click.stop>
						<view class="popup-title">确认重置</view>
						<view class="reset-content">确定要重置模拟吗？所有进度将被清除</view>
						<view class="popup-btns">
							<u-button type="default" @click="closeResetConfirmPopup">
								<text>取消</text>
							</u-button>
							<u-button type="error" @click="confirmReset">
								<text>确认重置</text>
							</u-button>
						</view>
					</view>
				</view>

				<!-- 熊猫操作菜单 -->
				<view v-if="pandaState.showPandaMenu" class="panda-popup-overlay" @click="closePandaMenu">
					<view class="panda-popup panda-menu-popup" @click.stop>
						<view class="menu-close" @click="closePandaMenu">✕</view>
						<view class="popup-title">
							{{pandaState.selectedPanda.name}}
							<text class="star-display">{{ '★'.repeat(pandaState.selectedPanda.star) }}</text>
						</view>
						<view class="popup-panda small">
							<image :src="'/static/mini/' + pandaState.selectedPanda.image" mode="aspectFit"></image>
							<view v-if="pandaState.selectedPanda.hasCharm" class="charm-badge"><image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit" class="charm-img"></image></view>
						</view>
						<view class="menu-btns">
							<view class="menu-btn-group">
								<u-button v-if="pandaState.selectedPandaLocation === 'bench'" type="primary"
									@click="movePanda('board')">
									<text>上场</text>
								</u-button>
								<u-button v-else type="primary" @click="movePanda('bench')">
									<text>下场</text>
								</u-button>
							</view>
							<view class="menu-btn-group">
								<u-button v-if="!pandaState.selectedPanda.hasCharm && pandaState.backpackCharms > 0"
									type="warning" @click="assignCharmFromMenu">
									<text>分配</text>
								</u-button>
								<u-button v-if="pandaState.selectedPanda.hasCharm" type="warning"
									@click="removeCharmFromPanda">
									<text>取下</text>
								</u-button>
							</view>
							<view class="menu-btn-group">
								<u-button class="sell-btn" @click="sellPanda">
									<text>出售</text>
								</u-button>
							</view>
						</view>
					</view>
				</view>

				<!-- 操作弹窗 -->
				<view v-if="pandaState.showOperationPopup" class="panda-popup-overlay" @click="closeOperationPopup">
					<view class="panda-popup operation-popup" @click.stop>
						<view class="popup-title">操作面板</view>

						<view class="operation-section">
							<view class="section-title">场上熊猫 (点击移动/出售)</view>
							<view class="operation-pandas">
								<view v-for="(panda, idx) in pandaState.boardPandas.filter(p => p)" :key="'opb'+idx"
									class="operation-panda"
									@click="showPandaMenu(pandaState.boardPandas.indexOf(panda), 'board')">
									<image :src="'/static/mini/' + panda.image" mode="aspectFit"></image>
									<text class="panda-star">{{ '★'.repeat(panda.star) }}</text>
								</view>
								<text v-if="pandaState.boardPandas.filter(p => p).length === 0"
									class="no-panda">暂无熊猫</text>
							</view>
						</view>

						<view class="operation-section">
							<view class="section-title">场下熊猫 (点击移动/出售)</view>
							<view class="operation-pandas">
								<view v-for="(panda, idx) in pandaState.benchPandas.filter(p => p)" :key="'opbe'+idx"
									class="operation-panda"
									@click="showPandaMenu(pandaState.benchPandas.indexOf(panda), 'bench')">
									<image :src="'/static/mini/' + panda.image" mode="aspectFit"></image>
									<text class="panda-star">{{ '★'.repeat(panda.star) }}</text>
								</view>
								<text v-if="pandaState.benchPandas.filter(p => p).length === 0"
									class="no-panda">暂无熊猫</text>
							</view>
						</view>

						<view class="operation-section" v-if="pandaState.backpackCharms > 0">
							<view class="section-title">背包挂坠 (点击分配)</view>
							<view class="operation-charms">
								<view v-for="i in pandaState.backpackCharms" :key="'opc'+i" class="operation-charm"
									@click="showAssignCharmMenu">
									<image src="/static/items/item_custom/item_slark_fish_bait.png" mode="aspectFit">
									</image>
								</view>
							</view>
						</view>

						<view class="popup-btns">
							<u-button @click="closeOperationPopup">关闭</u-button>
						</view>
					</view>
				</view>

				<u-popup :show="showCell" mode="center" :round="20" @close="showCell = false">
					<view class="popCellChesses">
						<view class='popCellChess' @click="toggleChessInPool(chess)"
							:class="{'pop-chess-selected': choosePool.some(c => c.id === chess.id)}"
							v-for="(chess, cIdx) in cellChesses" :key="cIdx" v-if="chess">
							<image :src="chess.photo" style="width: 64rpx;height: 64rpx;" alt="" v-if="chess.photo" />
						</view>
					</view>
				</u-popup>
				<u-popup :show="showTips" mode="center" closeable :round="20"  @close="showTips = false">
					<view class="uni-padding-wrap uni-common-mt">
						<view class="title">{{version}}</view>
						<view class="text-box">
							<text>
								{{tip}}
							</text>
						</view>
					</view>
				</u-popup>
				<u-popup :show="showDetail" mode="top" @close="closeDetail" closeable>
					<scroll-view class="chess-detail-scroll " scroll-y>
						<view class="chess-detail" v-if="currentChess">
							<!-- 奇观轮虚拟棋子特殊显示 -->
							<view class="detail-header" v-if="currentChess.isWheelBonus">
								<image :src="'/static/items/item_custom/rm_wheel_of_wonder.png'" class="detail-photo" />
								<view class="detail-info">
									<view class="detail-name-row">
										<text class="detail-name">奇观轮</text>
									</view>
									<text class="detail-desc">圣物效果：选择的羁绊额外+1计数</text>
								</view>
							</view>
							<!-- 正常棋子显示 -->
							<view class="detail-header" v-else>
								<image :src="currentChess.photo" class="detail-photo" v-if="currentChess.photo" />
								<view class="detail-info">
									<view class="detail-name-row">
										<text class="detail-name">{{currentChess.name}}</text>
										<text v-if="currentChess.isuse !== 1" class="detail-blackhouse-tag">小黑屋</text>
									</view>
									<text class="detail-cost"
										:style="'color:'+level[currentChess.cost]">{{currentChess.cost}}费</text>
									<view class="detail-tags">
										<!-- 百戏大王特殊显示 -->
										<view v-if="currentChess.id === 115" class="ringmaster-tags">
											<text class="ringmaster-hint">开局随机获得3个职业</text>
										</view>
										<template v-else>
											<view class="detail-tag-icon clickable"
												v-for="(major, idx) in getChessMajors(currentChess)" :key="idx"
												@click="showMajorDetail(major)">
												<image :src="major.photo" mode="aspectFit" />
											</view>
										</template>
									</view>
								</view>
							</view>
							<view class="detail-skill" v-if="currentChess.skill_desc && !currentChess.isWheelBonus">
								<text class="skill-title">技能</text>
								<text class="skill-desc">{{currentChess.skill_desc}}</text>
								<view class="skill-type-section" v-if="currentChess.skill_type">
									<text class="skill-type">类型: {{currentChess.skill_type}}</text>
									<text class="skill-type-desc">{{getSkillTypeDesc(currentChess.skill_type)}}</text>
								</view>
							</view>
							<!-- 百戏大王职业选择 -->
							<view v-if="currentChess.id === 115 && !currentChess.isWheelBonus" class="ringmaster-occ">
								<text class="ringmaster-title">选择职业（参与羁绊计算）</text>
								<view class="ringmaster-occ-list">
									<view v-for="occ in getAvailableOccs()" :key="occ.id" class="ringmaster-occ-item"
										:class="{'selected': isOccSelected(occ.id)}"
										@click="toggleOccSelection(occ.id)">
										<image :src="occ.photo" mode="aspectFit" />
									</view>
								</view>
								<text class="ringmaster-count">已选择: {{selectedOccs.length}}/3</text>
							</view>
							<!-- 种族/职业详情展示 -->
							<view v-if="selectedMajor && !currentChess.isWheelBonus" class="major-detail">
								<view class="major-header">
									<image :src="selectedMajor.photo" class="major-icon" mode="aspectFit" />
									<view class="major-info">
										<text class="major-name"
											:style="'color:'+selectedMajor.color">{{selectedMajor.name}}</text>
										<text class="major-type">{{selectedMajor.type === 1 ? '种族' : '职业'}}</text>
									</view>
								</view>
								<text class="major-desc">{{selectedMajor.desc}}</text>
								<!-- 该种族/职业的所有棋子 -->
								<view class="major-chesses" v-if="getMajorChesses(selectedMajor).length > 0">
									<text class="chesses-title">包含棋子</text>
									<view class="chesses-list">
										<view v-for="(chess, cIdx) in getMajorChesses(selectedMajor)" :key="cIdx"
											class="chess-item"
											:class="{'current-chess': chess.id === currentChess.id, 'in-pool': isInPool(chess.id)}"
											@click="switchToChess(chess)">
											<image :src="chess.photo" mode="aspectFit" />
											<text class="chess-name">{{chess.name}}</text>
											<text v-if="chess.id === currentChess.id" class="current-tag">当前</text>
											<view v-if="isInPool(chess.id)" class="pool-check">✓</view>
										</view>
									</view>
								</view>
								<view class="major-fetters" v-if="getMajorFetters(selectedMajor.id).length > 0">
									<text class="fetters-title">羁绊效果</text>
									<view class="fetter-item"
										v-for="(fetter, fIdx) in getMajorFetters(selectedMajor.id)" :key="fIdx">
										<text class="fetter-condition">{{fetter.name}}: </text>
										<text class="fetter-desc">{{fetter.desc}}</text>
									</view>
								</view>

							</view>
						</view>
					</scroll-view>
					<view class="detail-actions" v-if="currentChess && currentChess.isuse === 1">
						<button class="remove-btn" v-if="!repeatMode && isInPool(currentChess.id)"
							@click="removeFromPoolByDetail">移出</button>
						<button class="add-btn" v-else @click="addToPool">加入</button>
					</view>
				</u-popup>
				<u-popup :show="showConfirm" mode="center" @close="showConfirm = false">
					<view class="confirm-dialog">
						<view class="confirm-title">{{confirmTitle}}</view>
						<view class="confirm-content">{{confirmContent}}</view>
						<view class="confirm-actions">
							<button class="confirm-btn cancel" @click="showConfirm = false">取消</button>
							<button class="confirm-btn confirm" @click="handleConfirm">确定</button>
						</view>
					</view>
				</u-popup>
				<!-- 奇观轮羁绊选择面板 -->
				<u-popup :show="showWheelPopup" mode="center" :round="20" @close="showWheelPopup = false">
					<view class="wheel-popup">
						<view class="wheel-popup-title">选择羁绊（最多4个）</view>
						<!-- 已选羁绊展示 -->
						<view class="wheel-selected" v-if="selectedWheelFetters.length > 0">
							<view v-for="(fetter, index) in selectedWheelFetters" :key="'selected-'+index"
								class="wheel-selected-item" @click="removeWheelFetterByIndex(index)">
								<image :src="fetter.photo" mode="aspectFit" />
								<view class="wheel-remove-icon">×</view>
							</view>
						</view>
						<view class="wheel-popup-content">
							<!-- 种族列表 -->
							<view class="wheel-section">
								<text class="wheel-section-title">种族</text>
								<view class="wheel-fetter-list">
									<view v-for="major in getRaceMajors()" :key="major.id"
										class="wheel-fetter-item"
										:class="{'selected': getWheelFetterCount(major.id) > 0}"
										@click="toggleWheelFetter(major)">
										<view class="wheel-fetter-icon-wrapper">
											<image :src="major.photo" mode="aspectFit" />
											<view v-if="getWheelFetterCount(major.id) > 0" class="wheel-count-badge">
												{{getWheelFetterCount(major.id)}}
											</view>
										</view>
										<text>{{major.name}}</text>
									</view>
								</view>
							</view>
							<!-- 职业列表 -->
							<view class="wheel-section">
								<text class="wheel-section-title">职业</text>
								<view class="wheel-fetter-list">
									<view v-for="major in getOccMajors()" :key="major.id"
										class="wheel-fetter-item"
										:class="{'selected': getWheelFetterCount(major.id) > 0}"
										@click="toggleWheelFetter(major)">
										<view class="wheel-fetter-icon-wrapper">
											<image :src="major.photo" mode="aspectFit" />
											<view v-if="getWheelFetterCount(major.id) > 0" class="wheel-count-badge">
												{{getWheelFetterCount(major.id)}}
											</view>
										</view>
										<text>{{major.name}}</text>
									</view>
								</view>
							</view>
						</view>
						<view class="wheel-popup-actions">
							<button class="wheel-btn cancel" @click="showWheelPopup = false">取消</button>
							<button class="wheel-btn confirm" @click="confirmWheelSelection">确定</button>
						</view>
					</view>
				</u-popup>
			</view>
		</view>
		</view>
	</view>
</template>

<script>
	// 导入数据
	import chessData from '@/static/data/chesses.json'
	import majorData from '@/static/data/majors.json'
	import fetterData from '@/static/data/fetters.json'
	import skillTypeData from '@/static/data/skillTypes.json'
	import itemData from '@/static/data/items.json'
	import relicData from '@/static/data/relic.json'

	export default {
		data() {
			return {
				openid: '',
				list: [{
					name: '棋子'
				}, {
					name: '种族'
				}, {
					name: '职业'
				}, {
					name: '羁绊'
				}, {
					name: '装备'
				}, {
					name: '圣物'
				}, {
					name: '鱼塘'
				}],
				active: 0,
				//棋子
				chesses: [],
				//种族职业
				majors: [],
				//羁绊数据
				fetters: [],
				//种族卡池
				raChesses: [],
				//职业卡池
				occChesses: [],
				//选择卡池
				choosePool: [],
				//费用卡池
				costChesses: [],
				//羁绊
				choosefetters: [],
				// 羁绊视图模式：'list' 列表模式 | 'tile' 方块格子模式
				fetterViewMode: 'tile',
				//棋子羁绊表
				raocTale: [],
				cellChesses: [],
				fullscreen: false,
				fetterHidden: false,
				showCell: false,
				lineUps: [],
				showTips: false,
				showDetail: false,
				currentChess: null,
				darkMode: true,
				showConfirm: false,
				confirmTitle: '',
				confirmContent: '',
				confirmCallback: null,
				// 百戏大王选择的职业
				selectedOccs: [],
				// 百戏大王职业映射（存储每个百戏大王的职业）
				ringmasterOccMap: {},
			// 百戏大王棋子数据
			ringmasterChess: null,
			// 奇观轮选择的羁绊 (最多4个)
			selectedWheelFetters: [],
			// 重复模式开关
			repeatMode: false,
			// 选中的种族/职业详情
			selectedMajor: null,
				// 未启用的棋子（小黑屋）
				disabledChesses: [],
				// 装备数据
				items: [],
				// 圣物数据
				relics: [],
				// 熊猫模拟器数据
				pandaData: [{
						id: 'chess_brew',
						name: '熊猫酒仙',
						cost: 2,
						dialogs: ['是谁在那？给我滚出来', '再来一杯','干杯', '开心时刻','这杯我请客']
					},
					{
						id: 'chess_ember',
						name: '灰烬之灵',
						cost: 4,
						dialogs: ['守卫火焰','普天同庆','人多火旺','无中生有',]
					},
					{
						id: 'chess_earth',
						name: '大地之灵',
						cost: 4,
						dialogs: ['精灵由大地而生','巨石出来吧']
					},
					{
						id: 'chess_storm',
						name: '风暴之灵',
						cost: 4,
						dialogs: ['我像狂风一样,所向披靡','哦，看那个怪叔叔是谁','其他人在哪？','高考把我自己吹下来了']
					},
					{
						id: 'chess_void',
						name: '虚无之灵',
						cost: 4,
						dialogs: ['我本应如此','看那边','虚无的化身']
					}
				],
			pandaState: {
					currentRound: 1,
					isRunning: false,
					defenseEnabled: true,
					immortalMode: 0, // 修仙模式境界等级：0-11 对应 炼气到道祖

					boardPandas: new Array(32).fill(null),
					benchPandas: new Array(8).fill(null),
					backpackCharms: 0,
					charms: 0,
					maxCharms: 6,
					droppedPandas: 0,
					statusText: '等待开始模拟',
					statusLogs: [],
					logFilters: {
						info: true,
						error: true,
						combine: true,
						charm: true,
						sell: true
					},
					showPandaPopup: false,
					caughtPanda: null,
					caughtPandaSource: '抽卡',
					showDropPopup: false,
					dropPanda: null,
					showCharmPopup: false,
					showNoPandaPopup: false,
					showResetConfirmPopup: false,
					showHelpPopup: false,
					showPandaMenu: false,
					showResetConfirmPopup: false,
					isFinished: false,
					selectedPanda: null,
					selectedPandaLocation: null,
					selectedPandaIndex: null,
					needPlayerAction: false,
					defenseCount: 0,
					isFirstPandaInBench: false,
					assigningFromBackpack: false,
					pandaStats: {
						chess_brew: {
							caught: 0,
							dropped: 0
						},
						chess_ember: {
							caught: 0,
							dropped: 0
						},
						chess_earth: {
							caught: 0,
							dropped: 0
						},
						chess_storm: {
							caught: 0,
							dropped: 0
						},
						chess_void: {
							caught: 0,
							dropped: 0
						}
					}
				},
				// 奇观轮选择面板
				showWheelPopup: false,
				version: "客户端版本【20260328】",
				tip: 'tips:\n(1)点击某个【种族】或者【职业】图标可以批量添加至选择框；点击【数字】按钮可以去除重复棋子；选择框最大支持棋子数量为16个。\n(2)【巫师】羁绊触发条件(战斗中),与【熊猫人】【人类】(开场前)、【德鲁伊】(非战斗)羁绊作用时间不同，望知晓！\n(3)双击已选棋子可单独移除 \n(4)如遇到问题请将邮件发送至 405434387@qq.com',
				level: {
					0: "#ffffff",
					1: "#969797",
					2: "#a8a9e5",
					3: "#3334ce",
					4: "#cd01cd",
					5: "#e17a02",
				},
				cost: [1, 2, 3, 4, 5],
			};
		},
		onLoad() {
			this.initTheme();
			this.initData();
		},
		methods: {
			// 显示提示（统一封装）
			showToast(title, icon = 'none', duration = 1500) {
				uni.showToast({
					icon,
					title,
					duration
				});
			},

			// 获取技能类型说明
			getSkillTypeDesc(type) {
				// 支持多个技能类型（用/分隔）
				if (!type) return '';
				const types = type.split('/').map(t => t.trim());
				const descs = types.map(t => {
					const skillType = skillTypeData.find(item => item.name === t);
					return skillType ? skillType.desc : '';
				}).filter(d => d);
				return descs.join('；');
			},

			// 初始化所有数据
			initData() {
				this.getChesses();
				this.getMajors();
				this.getFetters();
				this.getRaChesses();
				this.getOccChesses();
				this.getCostChesses();
				this.getTableChesses();
				this.getItems();
				this.getRelics();
				this.getmySaves();
			},

			// 获取棋子数据
			getChesses() {
				// 使用外部数据文件
				const allChesses = chessData.map(item => {
					item.photo = "/static/mini/" + (item.photo || item.icon);
					// 处理种族字段（可能包含多个），转换为字符串数组以便比较
					item.raceList = item.race ? item.race.split(',').map(id => String(id)) : [];
					return item
				});

				// 分离已启用和未启用的棋子
				this.chesses = allChesses.filter(c => c.isuse === 1);
				this.disabledChesses = allChesses.filter(c => c.isuse !== 1);

				// 获取百戏大王棋子数据
				this.ringmasterChess = this.chesses.find(c => c.id === 115) || null;
				
				// 初始化奇观轮选中羁绊
				this.selectedWheelFetters = [];
			},

			// 获取种族职业数据
			getMajors() {
				this.majors = majorData.map(item => {
					item.photo = "/static/majors/" + (item.photo || item.icon);
					return item
				});
			},

			// 获取羁绊数据
			getFetters() {
				this.fetters = fetterData;
			},

			// 获取装备数据
			getItems() {
				this.items = itemData.filter(item => item.isuse === 1).map(item => {
					item.photo = "/static/items/" + item.icon;
					return item;
				});
			},

			// 获取圣物数据
			getRelics() {
				this.relics = relicData.filter(relic => relic.isuse === 1).map(relic => {
					relic.photo = "/static/items/" + relic.image_url;
					return relic;
				});
			},

			// 熊猫模拟器方法
			showOperationMenu() {
				this.pandaState.showOperationPopup = true;
			},

			closeOperationPopup() {
				this.pandaState.showOperationPopup = false;
			},

			showAssignCharmMenu() {
				const boardPandas = this.pandaState.boardPandas.filter(p => p);
				if (boardPandas.length === 0) {
					uni.showToast({
						icon: 'none',
						title: '场上没有熊猫',
						duration: 1500
					});
					return;
				}
				this.closeOperationPopup();
				this.pandaState.assigningFromBackpack = true;
				this.pandaState.showCharmPopup = true;
			},

			assignBackpackCharm() {
				this.showAssignCharmMenu();
			},

			addStatusLog(text, type = 'info') {
				this.pandaState.statusLogs.unshift({
					text,
					type
				});
			},

			toggleLogFilter(type) {
				this.pandaState.logFilters[type] = !this.pandaState.logFilters[type];
			},

			getFilteredLogs() {
				const filters = this.pandaState.logFilters;
				return this.pandaState.statusLogs.filter(log => {
					return filters[log.type] !== false;
				});
			},

			togglePandaRun() {
				if (this.pandaState.currentRound > 50) {
					uni.showToast({
						icon: 'none',
						title: '模拟已结束，请重置',
						duration: 1500
					});
					return;
				}

				// 开始新游戏时记录日志
				if (this.pandaState.currentRound === 1 && !this.pandaState.initialPandaPlaced) {
					this.addStatusLog('开始模拟', 'info');
				}

				// 如果有弹窗显示中，不能继续
				if (this.pandaState.showCharmPopup || this.pandaState.showPandaPopup || this.pandaState.showDropPopup || this.pandaState.showNoPandaPopup) {
					return;
				}

				// 如果需要玩家操作（放置熊猫等），点击继续进入下一回合
				if (this.pandaState.needPlayerAction) {
					this.continueToNext();
					return;
				}

				if (this.pandaState.isRunning) {
					this.pandaState.isRunning = false;
					this.pandaState.statusText = '已暂停';
					return;
				}

				this.pandaState.isRunning = true;
				this.pandaState.statusText = '模拟运行中...';
				this.runPandaRound();
			},

			continueToNext() {
				this.pandaState.needPlayerAction = false;
				this.pandaState.currentRound++;
				if (this.pandaState.currentRound > 50) {
					this.pandaState.isRunning = false;
					this.pandaState.statusText = '模拟结束!';
					this.pandaState.isFinished = true;
					this.addStatusLog('模拟结束', 'info');
				} else {
					this.pandaState.isRunning = true;
					this.addStatusLog(`第 ${this.pandaState.currentRound} 回合开始`, 'info');
					this.runPandaRound();
				}
			},

			showPandaMenu(index, location) {
				const panda = location === 'board' ? this.pandaState.boardPandas[index] : this.pandaState.benchPandas[
					index];
				if (!panda) return;

				this.pandaState.selectedPanda = panda;
				this.pandaState.selectedPandaLocation = location;
				this.pandaState.selectedPandaIndex = index;
				this.pandaState.showPandaMenu = true;
			},

			closePandaMenu() {
				this.pandaState.showPandaMenu = false;
				this.pandaState.selectedPanda = null;
				this.pandaState.selectedPandaLocation = null;
				this.pandaState.selectedPandaIndex = null;
			},

			movePanda(targetLocation) {
				const {
					selectedPanda,
					selectedPandaLocation,
					selectedPandaIndex
				} = this.pandaState;
				if (!selectedPanda) return;

				// 从原位置移除
				if (selectedPandaLocation === 'board') {
					this.pandaState.boardPandas[selectedPandaIndex] = null;
				} else {
					this.pandaState.benchPandas[selectedPandaIndex] = null;
				}

				// 尝试放到目标位置
				if (targetLocation === 'board') {
					const emptyIndex = this.pandaState.boardPandas.findIndex(p => p === null);
					if (emptyIndex !== -1) {
						this.pandaState.boardPandas[emptyIndex] = selectedPanda;
						this.checkAndCombine(this.pandaState.boardPandas);
					}
				} else {
					const emptyIndex = this.pandaState.benchPandas.findIndex(p => p === null);
					if (emptyIndex !== -1) {
						this.pandaState.benchPandas[emptyIndex] = selectedPanda;
					} else {
						uni.showToast({
							icon: 'none',
							title: '目标位置已满',
							duration: 1500
						});
						// 恢复到原位置
						if (selectedPandaLocation === 'board') {
							this.pandaState.boardPandas[selectedPandaIndex] = selectedPanda;
						} else {
							this.pandaState.benchPandas[selectedPandaIndex] = selectedPanda;
						}
						this.closePandaMenu();
						return;
					}
				}

				// 关闭菜单
				this.closePandaMenu();
			},

			sellPanda() {
				const {
					selectedPanda,
					selectedPandaLocation,
					selectedPandaIndex
				} = this.pandaState;
				if (!selectedPanda) return;

				// 记录出售日志
				const starStr = '★'.repeat(selectedPanda.star);
				this.addStatusLog(`出售${selectedPanda.name}${starStr}`, 'sell');

				// 如果有挂坠，返回挂坠到背包
				if (selectedPanda.hasCharm) {
					this.pandaState.backpackCharms++;
					this.pandaState.charms--;
				}

				// 从位置移除
				if (selectedPandaLocation === 'board') {
					this.pandaState.boardPandas[selectedPandaIndex] = null;
				} else {
					this.pandaState.benchPandas[selectedPandaIndex] = null;
				}

				uni.showToast({
					icon: 'success',
					title: '已出售',
					duration: 1000
				});
				this.closePandaMenu();
			},

			assignCharmFromMenu() {
				const {
					selectedPanda,
					selectedPandaLocation,
					selectedPandaIndex
				} = this.pandaState;
				if (!selectedPanda || selectedPanda.hasCharm) return;
				if (this.pandaState.backpackCharms <= 0) {
					uni.showToast({
						icon: 'none',
						title: '背包没有挂坠',
						duration: 1500
					});
					return;
				}

				selectedPanda.hasCharm = true;
				this.pandaState.backpackCharms--;
				uni.showToast({
					icon: 'success',
					title: '已分配挂坠',
					duration: 1000
				});
				this.closePandaMenu();
			},

			removeCharmFromPanda() {
				const {
					selectedPanda,
					selectedPandaLocation,
					selectedPandaIndex
				} = this.pandaState;
				if (!selectedPanda || !selectedPanda.hasCharm) return;

				selectedPanda.hasCharm = false;
				this.pandaState.backpackCharms++;
				this.pandaState.charms++;
				uni.showToast({
					icon: 'success',
					title: '已取下挂坠',
					duration: 1000
				});
			},

			storeCharmToBackpack() {
				if (this.pandaState.assigningFromBackpack) {
					this.pandaState.showCharmPopup = false;
					this.pandaState.assigningFromBackpack = false;
					this.pandaState.statusText = '已取消分配';
				} else {
					this.pandaState.backpackCharms++;
					this.pandaState.charms--;
					this.pandaState.showCharmPopup = false;
					this.pandaState.needPlayerAction = true;
					this.pandaState.showContinuePopup = true;
				}
			},

			// 检查并合成熊猫
			checkAndCombine(targetArray) {
				let combined = false;

				// 循环检查直到没有更多可以合成
				while (true) {
					// 统计相同等级的熊猫数量
					const starCount = {};
					const starIndices = {};

					for (let i = 0; i < targetArray.length; i++) {
						const panda = targetArray[i];
						if (panda && panda.star < 3) {
							const key = panda.id + '_' + panda.star;
							if (!starCount[key]) {
								starCount[key] = 0;
								starIndices[key] = [];
							}
							starCount[key]++;
							starIndices[key].push(i);
						}
					}

					// 查找3个相同的来合成
					let combinedKey = null;
					for (const key in starCount) {
						if (starCount[key] >= 3) {
							combinedKey = key;
							break;
						}
					}

					if (!combinedKey) break;

					const indices = starIndices[combinedKey];
					const panda = targetArray[indices[0]];
					const newStar = panda.star + 1;

					// 合成新熊猫
					const newPanda = {
						...panda,
						star: newStar
					};

					// 移除3个旧熊猫前，检查挂坠情况
					let charmsInCombine = 0;
					for (let i = 0; i < 3; i++) {
						if (targetArray[indices[i]] && targetArray[indices[i]].hasCharm) {
							charmsInCombine++;
							targetArray[indices[i]].hasCharm = false;
						}
						targetArray[indices[i]] = null;
					}

					// 找出空位放置新熊猫
					const emptyIndex = targetArray.findIndex(p => p === null);
					if (emptyIndex !== -1) {
						// 新熊猫保留一个挂坠（如果有的话）
						if (charmsInCombine > 0) {
							newPanda.hasCharm = true;
							charmsInCombine--; // 用掉一个挂坠
						}
						targetArray[emptyIndex] = newPanda;
						combined = true;

						// 添加合成日志
						this.addStatusLog(`合成: ${panda.name} ${panda.star}★ → ${newStar}★`, 'combine');

						// 多余的挂坠存回背包
						if (charmsInCombine > 0) {
							this.pandaState.backpackCharms += charmsInCombine;
						}
					}
				}

				return combined;
			},

			runPandaRound() {
				if (!this.pandaState.isRunning || this.pandaState.currentRound > 50) {
					return;
				}

				const round = this.pandaState.currentRound;
				const isWildRound = [1, 2, 10, 15, 20, 25, 30, 35, 40, 45, 50].includes(round);

				// 第一回合自动放置一只熊猫（初始化，不算掉落）
				if (round === 1 && !this.pandaState.initialPandaPlaced) {
					const firstPanda = {
						...this.pandaData[0],
						image: 'npc_dota_hero_brewmaster_png.png',
						dialog: this.pandaData[0].dialogs[0],
						star: 1
					};
					this.pandaState.boardPandas[0] = firstPanda;
					this.pandaState.initialPandaPlaced = true;
				}

				// 阶段1: 抽卡 - 每回合都抽卡
				this.pandaState.statusText = `第${round}回合 - 抽卡中...`;

				setTimeout(() => {
					// 模拟抽5张卡
					// 1费棋子共10种，每种4张 = 40张，卡池扩大5倍 = 200张
					// 熊猫酒仙4张，每张买的概率 = 4 / 200 = 2%
					const totalLevel1Chess = 40 * 5; // 200张
					const pandaCount = 4;
					const buyProb = pandaCount / totalLevel1Chess; // 2% 概率

					// 模拟抽5张
					let caughtPanda = null;
					for (let i = 0; i < 5; i++) {
						if (Math.random() < buyProb) {
							// 抽到熊猫酒仙
							caughtPanda = {
								...this.pandaData[0],
								image: 'npc_dota_hero_brewmaster_png.png',
								dialog: this.pandaData[0].dialogs[Math.floor(Math.random() * this.pandaData[0]
									.dialogs.length)],
								star: 1
							};
							break;
						}
					}

				if (caughtPanda) {
						// 暂停，让玩家选择上场或场下
						this.pandaState.isRunning = false;
						this.pandaState.caughtPanda = caughtPanda;
						this.pandaState.caughtPandaSource = '抽卡';
						this.pandaState.showPandaPopup = true;
						this.pandaState.statusText = '请选择熊猫放置位置';
						this.addStatusLog(`第${round}回合: 抽卡获得${caughtPanda.name}`, 'error');

						// 抽到熊猫后不检测掉落，等待下一回合
						
						if (this.pandaState.benchPandas.filter(p => p).length === 0 && this.pandaState.boardPandas
							.filter(p => p).length === 0) {
							this.pandaState.isFirstPandaInBench = true;
						}
					} else {
						// 没抽到熊猫，检测熊猫掉落（每个回合都可能掉落）
						this.handlePandaDrop(round);
					}
				}, 500);
			},

			handlePandaDrop(round) {
				// 检测熊猫掉落（每个回合都可能掉落）
				const boardPandas = this.pandaState.boardPandas.filter(p => p);
				if (boardPandas.length > 0) {
					this.pandaState.statusText = `第${round}回合 - 检测熊猫掉落...`;

					setTimeout(() => {
						const dropResult = this.calculatePandaDrop(boardPandas);

						if (dropResult.dropped && dropResult.pandas && dropResult.pandas.length > 0) {
							this.pandaState.isRunning = false;
							this.pandaState.droppedPandasList = dropResult.pandas;
							this.pandaState.showDropPopup = true;
							this.pandaState.statusText = `熊猫掉落!(${dropResult.pandas.length}只)`;
							const pandaNames = dropResult.pandas.map(p => p.name).join(', ');
							this.addStatusLog(`第${round}回合: 掉落${pandaNames}`, 'error');
						} else {
							// 没掉落，检测护符
							this.handleCharmDrop(round);
						}
					}, 500);
				} else {
					// 没有场上熊猫，检测护符
					this.handleCharmDrop(round);
				}
			},

			calculatePandaDrop(boardPandas) {
				const droppedPandas = [];
				const pandamanCount = boardPandas.length;
				const charmCount = boardPandas.filter(p => p.hasCharm).length;

				// 基础概率配置
				const BASE_EFFECT1_PROB = 0.10; // 效果1基础概率10%
				const BASE_EFFECT2_PROB = 0.15; // 效果2基础概率15%
				
				// 修仙模式：概率倍数 = 1 + 境界等级 * 0.1
				const modeMultiplier = 1 + this.pandaState.immortalMode * 0.1;

				// 防非机制 - 初始值-4，每没钓到一次+1
				let defenseMultiplier = 1;
				if (this.pandaState.defenseEnabled) {
					defenseMultiplier = Math.pow(1.1, -4 + this.pandaState.defenseCount);
				}

				// 记录完整日志
				const logInfo = {
					round: this.pandaState.currentRound,
					pandamanCount: pandamanCount,
					charmCount: charmCount,
					defenseCount: this.pandaState.defenseCount,
					defenseMultiplier: parseFloat(defenseMultiplier.toFixed(4)),
					modeMultiplier: modeMultiplier,
					immortalMode: this.pandaState.immortalMode,
					luckyValue: parseFloat(((pandamanCount + charmCount * 0.25) / pandamanCount).toFixed(4)),
					effect1: null,
					effect2: [],
					result: { dropped: false, pandas: [] }
				};

				// 幸运挂坠效果: lucky_value = (pandaman_count + xingyun_count * 0.25) / pandaman_count
				const luckyValue = (pandamanCount + charmCount * 0.25) / pandamanCount;

				const pandaIcons = {
					'chess_brew': 'npc_dota_hero_brewmaster_png.png',
					'chess_ember': 'npc_dota_hero_ember_spirit_png.png',
					'chess_earth': 'npc_dota_hero_earth_spirit_png.png',
					'chess_storm': 'npc_dota_hero_storm_spirit_png.png',
					'chess_void': 'npc_dota_hero_void_spirit_png.png'
				};

				// 效果1：只要有1个或更多熊猫人，有一次概率掉落不在场的熊猫人
				if (pandamanCount >= 1) {
					// 获取场上已有的熊猫ID
					const existingPandaIds = boardPandas.map(p => p.id);
					// 过滤掉场上已有的熊猫
					const availablePandas = this.pandaData.filter(p => !existingPandaIds.includes(p.id));
					
					// 只有当有不在场的熊猫时才触发效果1
					if (availablePandas.length > 0) {
						// 效果1：整体概率，使用总体 lucky_value
						const baseProb = BASE_EFFECT1_PROB * modeMultiplier * luckyValue * defenseMultiplier;
						logInfo.effect1 = { prob: parseFloat((baseProb * 100).toFixed(2)) };

						if (Math.random() < baseProb) {
							const pandaType = availablePandas[Math.floor(Math.random() * availablePandas.length)];
							droppedPandas.push({
								...pandaType,
								image: pandaIcons[pandaType.id] || 'npc_dota_hero_brewmaster_png.png',
								dialog: '邀请了一个熊猫人',
								star: 1,
								source: '效果1'
							});
							logInfo.effect1.triggered = true;
							logInfo.effect1.panda = pandaType.id;
						}
					}
				}

				// 效果2：需要2种或更多不同种类的熊猫，每个熊猫独立计算掉落同名熊猫
				const uniquePandaTypes = [...new Set(boardPandas.map(p => p.id))];
				const hasMultipleTypes = uniquePandaTypes.length >= 2;
				
				if (pandamanCount >= 2 && hasMultipleTypes) {
					// 遍历每个熊猫人，每个熊猫独立计算掉落概率
					// 有挂坠的熊猫 lucky_value = 1.25，没有的是 1.0
					boardPandas.forEach(panda => {
						const luckyValueOfPanda = panda.hasCharm ? 1.25 : 1.0;
						const baseProb = BASE_EFFECT2_PROB * modeMultiplier * luckyValueOfPanda * defenseMultiplier;
						const prob = parseFloat((baseProb * 100).toFixed(2));
						logInfo.effect2.push({ panda: panda.id, prob: prob, triggered: false });

						if (Math.random() < baseProb) {
							const pandaType = this.pandaData.find(p => p.id === panda.id) || this.pandaData[0];
							droppedPandas.push({
								...pandaType,
								image: pandaIcons[pandaType.id] || 'npc_dota_hero_brewmaster_png.png',
								dialog: '邀请了一个同名熊猫人',
								star: 1,
								source: '效果2'
							});
							logInfo.effect2[logInfo.effect2.length - 1].triggered = true;
						}
					});
				}

				// 记录最终结果
				logInfo.result.dropped = droppedPandas.length > 0;
				logInfo.result.pandas = droppedPandas.map(p => ({ id: p.id, name: p.name }));

				// 更新防非计数 - 根据Dota源码，只有效果1没触发时才增加防非值
				const effect1Triggered = logInfo.effect1 && logInfo.effect1.triggered;
				if (!effect1Triggered && pandamanCount >= 1 && this.pandaState.defenseEnabled) {
					this.pandaState.defenseCount++;
				} else if (effect1Triggered) {
					this.pandaState.defenseCount = 0;
				}

				return {
					dropped: droppedPandas.length > 0,
					pandas: droppedPandas
				};
			},

			handleCharmDrop(round) {
				// 特定回合检测护符掉落
				const charmDropRounds = [1, 2, 10, 15, 20, 25, 30, 35, 40, 45, 50];

				if (round >= 50) {
					this.pandaState.isRunning = false;
					this.pandaState.statusText = '模拟结束!';
					this.pandaState.isFinished = true;
					this.addStatusLog('模拟结束', 'info');
					return;
				}

				if (charmDropRounds.includes(round) && (this.pandaState.charms + this.pandaState.backpackCharms) < this
					.pandaState.maxCharms) {
					this.pandaState.statusText = `第${round}回合 - 检测护符掉落...`;

					setTimeout(() => {
						// 打野回合挂坠掉落概率提高一倍 (20% -> 40%)
						if (Math.random() < 0.40) {
							this.pandaState.isRunning = false;
							this.pandaState.charms++;
							this.pandaState.showCharmPopup = true;
							this.pandaState.statusText = '获得幸运挂坠!';
							this.addStatusLog(`第${round}回合: 获得幸运挂坠!`, 'charm');
						} else {
							// 需要玩家继续
							this.pandaState.isRunning = false;
							this.pandaState.needPlayerAction = true;
							this.pandaState.showContinuePopup = true;
							this.pandaState.statusText = '回合结束，继续下一回合';
						}
					}, 500);
				} else {
					// 需要玩家继续
					this.pandaState.isRunning = false;
					this.pandaState.needPlayerAction = true;
					this.pandaState.statusText = '回合结束，继续下一回合';
				}
			},

			placePanda(location) {
				const panda = this.pandaState.caughtPanda;
				this.pandaState.showPandaPopup = false;

				if (location === 'board') {
					const emptyIndex = this.pandaState.boardPandas.findIndex(p => p === null);
					if (emptyIndex !== -1) {
						this.pandaState.boardPandas[emptyIndex] = panda;
						// 检查合成
						this.checkAndCombine(this.pandaState.boardPandas);
					}
				} else {
					const emptyIndex = this.pandaState.benchPandas.findIndex(p => p === null);
					if (emptyIndex !== -1) {
						this.pandaState.benchPandas[emptyIndex] = panda;
					} else {
						uni.showToast({
							icon: 'none',
							title: '场下已满',
							duration: 1500
						});
						return;
					}
				}

			this.pandaState.statusText = '已放置，等待继续';
				this.pandaState.needPlayerAction = true;
				this.pandaState.showContinuePopup = true;
			},

			moveAllToBoard() {
				const benchPandas = this.pandaState.benchPandas.filter(p => p);
				
				if (benchPandas.length === 0) {
					uni.showToast({ icon: 'none', title: '场下没有熊猫', duration: 1500 });
					return;
				}

				const emptySlots = this.pandaState.boardPandas.filter(p => p === null).length;
				if (emptySlots < benchPandas.length) {
					uni.showToast({ icon: 'none', title: `场上位置不足，还需${benchPandas.length - emptySlots}个位置`, duration: 2000 });
					return;
				}

				benchPandas.forEach(panda => {
					const emptyIndex = this.pandaState.boardPandas.findIndex(p => p === null);
					if (emptyIndex !== -1) {
						this.pandaState.boardPandas[emptyIndex] = panda;
					}
				});

				this.pandaState.benchPandas = new Array(8).fill(null);
				this.checkAndCombine(this.pandaState.boardPandas);

				uni.showToast({ icon: 'success', title: '已全部上场', duration: 1000 });
			},

			arrangeBoard() {
				const boardPandas = this.pandaState.boardPandas.filter(p => p);
				if (boardPandas.length === 0) {
					uni.showToast({ icon: 'none', title: '场上没有熊猫', duration: 1500 });
					return;
				}
				this.pandaState.boardPandas = new Array(32).fill(null);
				boardPandas.forEach((panda, index) => {
					this.pandaState.boardPandas[index] = panda;
				});
				this.checkAndCombine(this.pandaState.boardPandas);
				uni.showToast({ icon: 'success', title: '已整理', duration: 1000 });
			},

			closeDropPopup() {
				if (this.pandaState.droppedPandasList.length === 0) {
					this.pandaState.showDropPopup = false;
					return;
				}
				
				const droppedPandas = [...this.pandaState.droppedPandasList];
				this.pandaState.showDropPopup = false;
				this.pandaState.droppedPandas += droppedPandas.length;
				this.pandaState.droppedPandasList = [];

				droppedPandas.forEach(droppedPanda => {
					if (droppedPanda.id && this.pandaState.pandaStats[droppedPanda.id]) {
						this.pandaState.pandaStats[droppedPanda.id].dropped++;
					}
				});

				const benchEmptyCount = this.pandaState.benchPandas.filter(p => p === null).length;
				
				droppedPandas.forEach((droppedPanda, index) => {
					if (index < benchEmptyCount) {
						const benchEmptyIndex = this.pandaState.benchPandas.findIndex(p => p === null);
						if (benchEmptyIndex !== -1) {
							this.pandaState.benchPandas[benchEmptyIndex] = droppedPanda;
						}
					} else {
						const boardEmptyIndex = this.pandaState.boardPandas.findIndex(p => p === null);
						if (boardEmptyIndex !== -1) {
							this.pandaState.boardPandas[boardEmptyIndex] = droppedPanda;
						}
					}
				});

				this.checkAndCombine(this.pandaState.boardPandas);

				const notPlaced = droppedPandas.length - (this.pandaState.benchPandas.filter(p => p).length + this
					.pandaState.boardPandas.filter(p => p).length);
				if (notPlaced > 0) {
					uni.showToast({
						icon: 'none',
						title: `${notPlaced}只熊猫因位置不足未放置`,
						duration: 1500
					});
				}

				// 继续检测护符
				const round = this.pandaState.currentRound;
				this.handleCharmDrop(round);
			},

			assignCharm(panda) {
				panda.hasCharm = true;
				this.pandaState.showCharmPopup = false;

				if (this.pandaState.assigningFromBackpack) {
					this.pandaState.backpackCharms--;
					this.pandaState.statusText = '已从背包分配挂坠';
					this.pandaState.assigningFromBackpack = false;
				} else {
					this.pandaState.charms--;
					this.pandaState.statusText = '已分配，继续下一回合';
					this.pandaState.currentRound++;
					setTimeout(() => {
						this.pandaState.isRunning = true;
						this.runPandaRound();
					}, 500);
				}
			},

			closeNoPandaPopup() {
				this.pandaState.showNoPandaPopup = false;
				this.pandaState.isRunning = true;
				this.runPandaRound();
			},

			showPandaHelp() {
				this.pandaState.showHelpPopup = true;
			},

			getImmortalName() {
				const levels = ['修仙', '炼气', '筑基', '结丹', '元婴', '化神', '炼虚', '合体', '大乘', '真仙', '金仙', '太乙', '大罗','道祖'];
				return levels[this.pandaState.immortalMode] || '修仙';
			},

			toggleImmortalMode() {
				this.pandaState.immortalMode = (this.pandaState.immortalMode + 1) % 14;
			},

			closeHelpPopup() {
				this.pandaState.showHelpPopup = false;
			},

			getPandaImage(id) {
				const images = {
					chess_brew: 'npc_dota_hero_brewmaster_png.png',
					chess_ember: 'npc_dota_hero_ember_spirit_png.png',
					chess_earth: 'npc_dota_hero_earth_spirit_png.png',
					chess_storm: 'npc_dota_hero_storm_spirit_png.png',
					chess_void: 'npc_dota_hero_void_spirit_png.png'
				};
				return images[id] || '';
			},

			getPandaDropRates() {
				const boardPandas = this.pandaState.boardPandas.filter(p => p);
				if (boardPandas.length === 0) return {};

				const pandamanCount = boardPandas.length;
				const charmCount = boardPandas.filter(p => p.hasCharm).length;
				
				// 获取场上已有的熊猫ID
				const existingPandaIds = boardPandas.map(p => p.id);
				// 场上不同种类熊猫数量
				const uniquePandaTypes = [...new Set(existingPandaIds)];
				const hasMultipleTypes = uniquePandaTypes.length >= 2;

				// 基础概率配置
				const BASE_EFFECT1_PROB = 0.10;
				const BASE_EFFECT2_PROB = 0.15;
				
				// 修仙模式：概率倍数 = 1 + 境界等级 * 0.1
				const modeMultiplier = 1 + this.pandaState.immortalMode * 0.1;

				// 防非机制 - 初始值-4，每没钓到一次+1
				let defenseMultiplier = 1;
				if (this.pandaState.defenseEnabled) {
					defenseMultiplier = Math.pow(1.1, -4 + this.pandaState.defenseCount);
				}

				// 幸运挂坠效果: lucky_value = (pandaman_count + xingyun_count * 0.25) / pandaman_count
				const luckyValue = (pandamanCount + charmCount * 0.25) / pandamanCount;

				const rates = {};

				// 检查是否有不在场的熊猫（效果1需要）
				const availablePandas = this.pandaData.filter(p => !existingPandaIds.includes(p.id));
				const hasAvailablePandas = availablePandas.length > 0;

				// 为所有熊猫种类显示概率
				this.pandaData.forEach(panda => {
					// 检查是否有这种熊猫在场上
					const pandasOfType = boardPandas.filter(p => p.id === panda.id);
					
					if (pandasOfType.length > 0) {
						// 场上有这种熊猫
						if (pandamanCount >= 2 && hasMultipleTypes) {
							// 2种以上熊猫：显示效果1 + 效果2的综合概率
							// 效果2：每个熊猫独立计算概率，然后求和
							let effect2Prob = 0;
							pandasOfType.forEach(p => {
								const luckyValueOfPanda = p.hasCharm ? 1.25 : 1.0;
								effect2Prob += BASE_EFFECT2_PROB * modeMultiplier * luckyValueOfPanda * defenseMultiplier;
							});
							// 效果1 + 效果2（两个独立，可以同时触发）
							const effect1Prob = BASE_EFFECT1_PROB * modeMultiplier * luckyValue * defenseMultiplier;
							const totalProb = effect1Prob + effect2Prob;
							rates[panda.id] = (totalProb * 100).toFixed(1) + '%';
						} else {
							// 只有1种熊猫：效果1是掉落不在场的熊猫，场上熊猫显示0%
							rates[panda.id] = '0%';
						}
					} else {
						// 场上没有这种熊猫
						if (hasAvailablePandas) {
							// 有不在场的熊猫，显示效果1的概率（整体概率，使用总体 lucky_value）
							const effect1Prob = BASE_EFFECT1_PROB * modeMultiplier * luckyValue * defenseMultiplier;
							rates[panda.id] = (effect1Prob * 100).toFixed(1) + '%';
						} else {
							// 所有熊猫类型都在场，效果1无法触发
							rates[panda.id] = '0%';
						}
					}
				});

				return rates;
			},

			getPandaName(id) {
				const names = {
					chess_brew: '熊猫酒仙',
					chess_ember: '灰烬之灵',
					chess_earth: '大地之灵',
					chess_storm: '风暴之灵',
					chess_void: '虚无之灵'
				};
				return names[id] || id;
			},

			getTotalCaught() {
				const stats = this.pandaState.pandaStats;
				return (stats.chess_brew?.caught || 0) + (stats.chess_ember?.caught || 0) +
					(stats.chess_earth?.caught || 0) + (stats.chess_storm?.caught || 0) +
					(stats.chess_void?.caught || 0);
			},

			getTotalDropped() {
				const stats = this.pandaState.pandaStats;
				return (stats.chess_brew?.dropped || 0) + (stats.chess_ember?.dropped || 0) +
					(stats.chess_earth?.dropped || 0) + (stats.chess_storm?.dropped || 0) +
					(stats.chess_void?.dropped || 0);
			},

			closeCharmPopup() {
				// 如果有未分配的挂坠，存入背包
				if (this.pandaState.charms > 0) {
					this.pandaState.backpackCharms++;
					this.pandaState.charms--;
				}
				this.pandaState.showCharmPopup = false;
				this.pandaState.currentRound++;
				setTimeout(() => {
					this.pandaState.isRunning = true;
					this.runPandaRound();
				}, 500);
			},

			resetPandaSim() {
				this.pandaState.showResetConfirmPopup = true;
			},

			closeResetConfirmPopup() {
				this.pandaState.showResetConfirmPopup = false;
			},

			confirmReset() {
				this.pandaState.showResetConfirmPopup = false;
				this.doResetPandaSim();
			},

			doResetPandaSim() {
				uni.showToast({
					icon: 'success',
					title: '已重置',
					duration: 1500
				});
				this.pandaState = {
					currentRound: 1,
					isRunning: false,
					defenseEnabled: true,
					immortalMode: 0,

					boardPandas: new Array(32).fill(null),
					benchPandas: new Array(8).fill(null),
					backpackCharms: 0,
					charms: 0,
					maxCharms: 6,
					droppedPandas: 0,
					droppedPandasList: [],
					statusText: '等待开始模拟',
					statusLogs: [],
					logFilters: {
						info: true,
						error: true,
						combine: true,
						charm: true,
						sell: true
					},
					showPandaPopup: false,
					caughtPanda: null,
					caughtPandaSource: '抽卡',
					showDropPopup: false,
					dropPanda: null,
					showCharmPopup: false,
					showNoPandaPopup: false,
					showPandaMenu: false,
					showOperationPopup: false,
					isFinished: false,
					selectedPanda: null,
					selectedPandaLocation: null,
					selectedPandaIndex: null,
					needPlayerAction: false,
					defenseCount: 0,
					isFirstPandaInBench: false,
					initialPandaPlaced: false,
					assigningFromBackpack: false,
					pandaStats: {
						chess_brew: {
							caught: 0,
							dropped: 0
						},
						chess_ember: {
							caught: 0,
							dropped: 0
						},
						chess_earth: {
							caught: 0,
							dropped: 0
						},
						chess_storm: {
							caught: 0,
							dropped: 0
						},
						chess_void: {
							caught: 0,
							dropped: 0
						}
					}
				};
			},

			// 获取种族/职业卡池（通用方法）
			getMajorChessesByType(type, key) {
				const result = [];
				const majors = this.majors.filter(item => item.type === type && item.isUse);

				majors.forEach(major => {
					const chesses = this.chesses
						.filter(s => s.isuse && (type === 1 ?
							s.raceList?.includes(String(major.id)) :
							s.occupation == major.id))
						.sort((a, b) => a.cost - b.cost);

					if (chesses.length > 0) {
						result.push({
							[key]: major,
							chesses
						});
					}
				});

				return result;
			},

			// 获取种族卡池
			getRaChesses() {
				this.raChesses = this.getMajorChessesByType(1, 'ra');
			},

			// 获取职业卡池
			getOccChesses() {
				this.occChesses = this.getMajorChessesByType(0, 'occ');
			},

			// 获取费用卡池
			getCostChesses() {
				this.costChesses = [];
				for (let i = 0; i < this.cost.length; i++) {
					let chesses = this.chesses.filter(s => s.cost == (i + 1)).sort((a, b) => a.cost - b.cost);
					var g = {};
					g.cost = i + 1;
					g.chesses = chesses;
					this.costChesses.push(g);
				}
			},

			// 获取羁绊表格
			getTableChesses() {
				let occs = this.majors.filter(item => item.type === 0 && item.isUse);
				let races = this.majors.filter(item => item.type === 1 && item.isUse);
				let table = [];

				for (let i = 0; i < occs.length + 1; i++) {
					let row = [];
					for (let j = 0; j < races.length + 1; j++) {
						let cell = {};

						if (i == 0 && j == 0) {
							cell.ra = "0";
							cell.occ = "0";
							cell.count = 1;
							let chess = {
								photo: "/static/fullscreen-expand.png",
								name: "",
								race: "0",
								occ: "0",
								cost: 0
							};
							cell.chesses = [chess];
						} else if (i > 0 && j == 0) {
							cell.occ = occs[i - 1].id;
							cell.ra = "0";
							cell.count = 1;
							let chess = {
								photo: occs[i - 1].photo,
								race: "0",
								name: occs[i - 1].name,
								occ: occs[i - 1].id,
								cost: 0
							};
							cell.chesses = [chess];
						} else if (i == 0 && j > 0) {
							cell.ra = races[j - 1].id;
							cell.occ = "0";
							cell.count = 1;
							let chess = {
								photo: races[j - 1].photo,
								race: races[j - 1].id,
								occ: "0",
								name: races[j - 1].name,
								cost: 0
							};
							cell.chesses = [chess];
						} else {
							let chesses = this.chesses.filter(s =>
								s.isuse &&
								s.raceList &&
								s.raceList.indexOf(String(races[j - 1].id)) !== -1 &&
								String(s.occupation) === String(occs[i - 1].id)
							).sort((a, b) => a.cost - b.cost);

							if (chesses.length == 0) {
								let chess = {
									photo: "",
									name: "",
									race: "0",
									occ: "0",
									cost: 0
								};
								chesses = [chess];
							}
							cell.chesses = chesses;
							cell.ra = races[j - 1].id;
							cell.occ = occs[i - 1].id;
							cell.count = chesses.length;
						}
						row.push(cell);
					}
					table.push(row);
				}
				this.raocTale = table;
			},

			// 切换标签页
			change(e) {
				this.active = e.index !== undefined ? e.index : e;
			},

			// 显示提示
			tips() {
				this.showTips = true;
			},



			getmySaves() {
				var that = this;
				uni.getStorage({
					key: "user",
					success: function(res) {
						that.openid = res.data
						that.getlist();
					},
				})
			},

			getlist() {
				this.$http.post('/Account/MyLineUps', {
					openid: this.openid,
				}).then(res => {
					this.lineUps = res.data;
				})
			},

			// 选择棋子（已优化去重逻辑）
			chooseChess(chess) {
				if (this.choosePool.length >= 16) {
					uni.showToast({
						icon: 'none',
						title: '最多只能选择16个棋子',
						duration: 1500
					});
					return;
				}

				// 非重复模式下检查是否已存在相同ID的棋子
				if (!this.repeatMode) {
					const exists = this.choosePool.some(item => item.id === chess.id);
					if (exists) {
						uni.showToast({
							icon: 'none',
							title: '该棋子已添加',
							duration: 1500
						});
						return;
					}
				}

				this.choosePool.push(chess);
				this.calculateFetters();

				// // 关闭弹窗
				// this.showCell = false;
			},

			// 显示棋子详情
			showChessDetail(chess) {
				this.currentChess = chess;
				// 百戏大王初始化已选择的职业
				if (chess.id === 115) {
					// 检查是否已有存储的职业选择
					const savedOccs = this.ringmasterOccMap[chess.id] || [];
					this.selectedOccs = [...savedOccs];
				} else {
					this.selectedOccs = [];
				}
				// 默认选中第一个种族或职业
				const majors = this.getChessMajors(chess);
				if (majors.length > 0) {
					this.selectedMajor = majors[0];
				} else {
					this.selectedMajor = null;
				}
				this.showDetail = true;
			},

			// 点击羁绊图标显示第一个棋子详情
			showFetterChessDetail(fetter) {
				if (fetter.chesses && fetter.chesses.length > 0) {
					const chess = fetter.chesses[0];
					this.currentChess = chess;
					// 百戏大王初始化已选择的职业
					if (chess.id === 115) {
						const savedOccs = this.ringmasterOccMap[chess.id] || [];
						this.selectedOccs = [...savedOccs];
					} else {
						this.selectedOccs = [];
					}
					// 设置当前羁绊对应的major为默认选中
					const fetterMajorId = String(fetter.majorId || fetter.fetter?.majorId);
					if (fetterMajorId) {
						const majorInfo = this.majors.find(m => String(m.id) === fetterMajorId);
						if (majorInfo) {
							this.selectedMajor = majorInfo;
						} else {
							// 找不到则使用第一个
							const majors = this.getChessMajors(chess);
							this.selectedMajor = majors.length > 0 ? majors[0] : null;
						}
					} else {
						const majors = this.getChessMajors(chess);
						this.selectedMajor = majors.length > 0 ? majors[0] : null;
					}
					this.showDetail = true;
				}
			},

			// 获取可用职业列表（排除百戏大王特殊职业）
			getAvailableOccs() {
				return this.majors.filter(m => m.type === 0 && m.id !== 37 && m.isUse !== 0);
			},

			// 检查职业是否被选中
			isOccSelected(occId) {
				return this.selectedOccs.includes(String(occId));
			},

			// 切换职业选择
			toggleOccSelection(occId) {
				const id = String(occId);
				const index = this.selectedOccs.indexOf(id);
				if (index > -1) {
					this.selectedOccs.splice(index, 1);
				} else {
					if (this.selectedOccs.length >= 3) {
						uni.showToast({
							icon: 'none',
							title: '最多选择3个职业',
							duration: 1500
						});
						return;
					}
					this.selectedOccs.push(id);
				}
			},

			// 显示百戏大王详情
			showRingmasterDetail() {
				if (this.ringmasterChess) {
					this.showChessDetail(this.ringmasterChess);
				}
			},

			// 加入选择卡池
			addToPool() {
				if (!this.currentChess) return;

				// 非重复模式下检查是否已存在
				if (!this.repeatMode) {
					const exists = this.choosePool.some(item => item.id === this.currentChess.id);
					if (exists) {
						uni.showToast({
							icon: 'none',
							title: '该棋子已添加',
							duration: 1500
						});
						return;
					}
				}

				if (this.choosePool.length >= 16) {
					uni.showToast({
						icon: 'none',
						title: '最多只能选择16个棋子',
						duration: 1500
					});
					return;
				}

				// 百戏大王需要选择3个职业
				if (this.currentChess.id === 115) {
					if (this.selectedOccs.length !== 3) {
						uni.showToast({
							icon: 'none',
							title: '请选择3个职业',
							duration: 1500
						});
						return;
					}
					// 保存百戏大王的职业选择
					this.$set(this.ringmasterOccMap, this.currentChess.id, [...this.selectedOccs]);
				}

				this.choosePool.push(this.currentChess);
				this.calculateFetters();
				this.selectedOccs = [];
			},

			// 从选择池移出棋子
			removeFromPoolByDetail() {
				if (!this.currentChess) return;

				const index = this.choosePool.findIndex(item => item.id === this.currentChess.id);
				if (index === -1) {
					uni.showToast({
						icon: 'none',
						title: '该棋子不在选择池中',
						duration: 1500
					});
					return;
				}

				this.choosePool.splice(index, 1);
				this.calculateFetters();

				// 如果是百戏大王，清除职业选择
				if (this.currentChess.id === 115) {
					this.$delete(this.ringmasterOccMap, this.currentChess.id);
					this.selectedOccs = [];
				}
			},

			// 获取major信息（种族/职业通用）
			getMajorInfo(id, type, field = 'name') {
				const major = this.majors.find(m => String(m.id) === String(id) && m.type === type);
				return major ? major[field] : '';
			},

			// 获取棋子的major IDs（种族/职业）
			getChessMajorIds(chess) {
				if (!chess || chess.id === 115) return {
					raceIds: [],
					occIds: []
				};

				const raceIds = chess.raceList || (chess.race ? String(chess.race).split(',') : []);
				const occIds = chess.occList || (chess.occupation ? String(chess.occupation).split(',') : []);

				return {
					raceIds,
					occIds
				};
			},

			// 获取棋子所有major图标（种族+职业）
			getChessMajorIcons(chess) {
				const {
					raceIds,
					occIds
				} = this.getChessMajorIds(chess);
				const icons = [];

				raceIds.forEach(id => {
					const major = this.majors.find(m => String(m.id) === String(id) && m.type === 1);
					if (major?.photo) icons.push(major.photo);
				});

				occIds.forEach(id => {
					if (String(id) === '37') return;
					const major = this.majors.find(m => String(m.id) === String(id) && m.type === 0);
					if (major?.photo) icons.push(major.photo);
				});

				return icons;
			},

			// 获取棋子所有major对象（种族+职业）
			getChessMajors(chess) {
				const {
					raceIds,
					occIds
				} = this.getChessMajorIds(chess);
				const majors = [];

				raceIds.forEach(id => {
					const major = this.majors.find(m => String(m.id) === String(id) && m.type === 1);
					if (major) majors.push(major);
				});

				occIds.forEach(id => {
					if (String(id) === '37') return;
					const major = this.majors.find(m => String(m.id) === String(id) && m.type === 0);
					if (major) majors.push(major);
				});

				return majors;
			},

			// 显示种族/职业详情
			showMajorDetail(major) {
				this.selectedMajor = major;
			},

			// 获取种族/职业的羁绊效果
			getMajorFetters(majorId) {
				return this.fetters.filter(f => String(f.majorId) === String(majorId)).sort((a, b) => a.condition - b
					.condition);
			},

			// 获取种族/职业的所有棋子
			getMajorChesses(major) {
				if (!major) return [];

				return this.chesses.filter(chess => {
					if (chess.id === 115) return false; // 排除百戏大王

					if (major.type === 1) {
						// 种族
						return chess.raceList && chess.raceList.includes(String(major.id));
					} else {
						// 职业
						let occIds = [];
						if (chess.occList && Array.isArray(chess.occList)) {
							occIds = chess.occList;
						} else if (chess.occupation) {
							occIds = String(chess.occupation).split(',');
						}
						return occIds.includes(String(major.id));
					}
				}).sort((a, b) => a.cost - b.cost);
			},

			// 关闭详情弹窗
			closeDetail() {
				this.showDetail = false;
				this.selectedMajor = null;
			},

			// 切换到其他棋子详情
			switchToChess(chess) {
				if (chess.id === this.currentChess.id) return;
				this.currentChess = chess;
				// 重新加载该棋子的选中职业（如果是百戏大王）
				if (chess.id === 115) {
					const key = 'ringmaster_' + chess.id;
					this.selectedOccs = this.ringmasterOccMap[key] || [];
				}
			},

			// 检查棋子是否已在选择池中
			isInPool(chessId) {
				return this.choosePool.some(c => c.id === chessId);
			},

			// 选择种族、职业所有棋子
			chooseRaocChesses(raocChess) {
				let available = 16 - this.choosePool.length;
				if (available <= 0) {
					uni.showToast({
						icon: 'none',
						title: '选择池已满',
						duration: 1500
					});
					return;
				}

				// 非重复模式下过滤出未选择的棋子
				let newChesses;
				if (!this.repeatMode) {
					const existingIds = new Set(this.choosePool.map(c => c.id));
					newChesses = raocChess.chesses.filter(c => !existingIds.has(c.id));

					if (newChesses.length === 0) {
						uni.showToast({
							icon: 'none',
							title: '没有未添加的棋子',
							duration: 1500
						});
						return;
					}
				} else {
					// 重复模式下直接使用所有棋子
					newChesses = raocChess.chesses;
				}

				let addCount = Math.min(available, newChesses.length);
				this.choosePool.push(...newChesses.slice(0, addCount));
				this.calculateFetters();
			},

			// 选择单元格
			chooseCell(cell) {
				// 0行0列 - 切换全屏
				if (cell.ra === "0" && cell.occ === "0") {
					this.toggleFullscreen();
					return;
				}

				// 职业/种族图标 - toggle逻辑
				if (cell.chesses[0].cost === 0) {
					if (cell.ra === "0" && cell.occ !== "0") {
						let occ = this.occChesses.find(s => s.occ.id === cell.occ);
						if (occ) {
							this.toggleChessesInPool(occ.chesses);
						}
					} else if (cell.ra !== "0" && cell.occ === "0") {
						let ra = this.raChesses.find(s => s.ra.id === cell.ra);
						if (ra) {
							this.toggleChessesInPool(ra.chesses);
						}
					}
					this.calculateFetters();
				} else {
					// 具体棋子
					if (cell.chesses.length > 1) {
						// 多个棋子，显示选择弹窗
						this.cellChesses = cell.chesses;
						this.showCell = true;
					} else {
						this.toggleChessInPool(cell.chesses[0]);
					}
				}
			},

			// 切换单个棋子的选择状态
			toggleChessInPool(chess) {
				// 非重复模式下，已存在则移除
				if (!this.repeatMode) {
					const index = this.choosePool.findIndex(c => c.id === chess.id);
					if (index !== -1) {
						this.choosePool.splice(index, 1);
						this.calculateFetters();
						return;
					}
				}

				// 检查数量上限
				if (this.choosePool.length >= 16) {
					uni.showToast({
						icon: 'none',
						title: '最多只能选择16个棋子',
						duration: 1500
					});
					return;
				}
				this.choosePool.push(chess);
				this.calculateFetters();
			},

			// 切换多个棋子的选择状态
			toggleChessesInPool(chesses) {
				// 非重复模式下的toggle逻辑
				if (!this.repeatMode) {
					const allSelected = chesses.every(chess =>
						this.choosePool.some(c => c.id === chess.id)
					);

					if (allSelected) {
						// 全部已选择，取消选择所有
						const chessIds = new Set(chesses.map(c => c.id));
						this.choosePool = this.choosePool.filter(c => !chessIds.has(c.id));
						this.calculateFetters();
						return;
					}
				}

				// 重复模式下，或非重复模式下部分未选择，直接添加
				const existingIds = new Set(this.choosePool.map(c => c.id));
				const newChesses = this.repeatMode
					? chesses
					: chesses.filter(c => !existingIds.has(c.id));
				const available = 16 - this.choosePool.length;

				if (available <= 0) {
					uni.showToast({
						icon: 'none',
						title: '选择池已满',
						duration: 1500
					});
					return;
				}

				const addCount = Math.min(available, newChesses.length);
				this.choosePool.push(...newChesses.slice(0, addCount));
				this.calculateFetters();
			},

			// 移除单个棋子
			removeChess(chess, index) {
				this.choosePool.splice(index, 1);
				this.calculateFetters();
			},

			// 移除重复棋子（已优化）
			removeRepeatchess() {
				const unique = [];
				const map = new Map();

				for (const item of this.choosePool) {
					if (!map.has(item.id)) {
						map.set(item.id, true);
						unique.push(item);
					}
				}

				if (unique.length !== this.choosePool.length) {
					this.choosePool = unique;
					this.calculateFetters();
					uni.showToast({
						icon: 'success',
						title: `已移除重复棋子`,
						duration: 1500
					});
				} else {
					uni.showToast({
						icon: 'none',
						title: '没有重复棋子',
						duration: 1500
					});
				}
			},

			// 显示确认弹窗
			showConfirmDialog(title, content, callback) {
				this.confirmTitle = title;
				this.confirmContent = content;
				this.confirmCallback = callback;
				this.showConfirm = true;
			},

			// 处理确认
			handleConfirm() {
				if (this.confirmCallback) {
					this.confirmCallback();
				}
				this.showConfirm = false;
			},

			// 奇观轮相关方法
			showWheelSelect() {
				this.showWheelPopup = true;
			},

			// 切换重复模式
			toggleRepeatMode() {
				this.repeatMode = !this.repeatMode;
				uni.showToast({
					icon: 'none',
					title: this.repeatMode ? '重复模式已开启，点击数量按钮去重' : '重复模式已关闭，点击数量按钮去重',
					duration: 5000
				});
			},

			getRaceMajors() {
				return this.majors.filter(m => m.type === 1 && m.isUse !== 0);
			},

			getOccMajors() {
				return this.majors.filter(m => m.type === 0 && m.isUse !== 0);
			},

			// 获取某个羁绊已选次数
			getWheelFetterCount(majorId) {
				return this.selectedWheelFetters.filter(f => f.id === majorId).length;
			},

			toggleWheelFetter(major) {
				// 支持重复选择同一个羁绊，最多4个
				if (this.selectedWheelFetters.length < 4) {
					this.selectedWheelFetters.push(major);
				} else {
					uni.showToast({ title: '最多选择4个羁绊', icon: 'none' });
				}
			},

			confirmWheelSelection() {
				this.showWheelPopup = false;
				// 触发羁绊重新计算
				this.calculateFetters();
			},

			// 弹窗内删除已选羁绊
			removeWheelFetterByIndex(index) {
				this.selectedWheelFetters.splice(index, 1);
			},

			removeWheelFetter(index) {
				this.selectedWheelFetters.splice(index, 1);
				// 触发羁绊重新计算
				this.calculateFetters();
			},

			// 清空选择池
			clearChessPool() {
				if (this.choosePool.length === 0 && this.selectedWheelFetters.length === 0) {
					return;
				}
				this.showConfirmDialog('提示', '确定清空所有已选棋子和奇观轮选择吗？', () => {
					this.choosePool = [];
					this.choosefetters = [];
					this.selectedWheelFetters = [];
				});
			},

			// 计算羁绊（核心修复）
			calculateFetters() {
				if (this.choosePool.length === 0) {
					this.choosefetters = [];
					return;
				}

				// 去重（保留完整对象属性）
				let uniqueMap = new Map();
				this.choosePool.forEach(chess => {
					if (!uniqueMap.has(chess.id)) {
						uniqueMap.set(chess.id, chess);
					}
				});
				let uniqueChesses = Array.from(uniqueMap.values());

				// 分别计算种族和职业羁绊
				let raceFetters = this.getGroupFetters(uniqueChesses, 'raceList');
				let occFetters = this.getGroupFetters(uniqueChesses, 'occupation', true);

				let allFetters = [...raceFetters, ...occFetters];

				// 处理巫师羁绊
				let wizardGroup = allFetters.find(s => s.key === "9");
				let wizardCount = wizardGroup ? wizardGroup.groups.length : 0;
				// 双巫师：2个巫师，羁绊需求≥4时减1
				let hasTwoWizard = wizardCount >= 2;

				// 四巫师判断：需要3个巫师（双巫师效果后4-1=3），且除巫师外只有1个其他羁绊
				// 计算除巫师外的羁绊数量（使用allFetters，不包含巫师）
				const otherFetterGroups = allFetters.filter(s => s.key !== "9");
				
				// 计算已激活的其他羁绊（四巫师只计算激活的羁绊）
				let activeOtherFetterIds = [];
				otherFetterGroups.forEach(group => {
					// 获取该羁绊的配置
					const fetterConfigs = this.fetters.filter(f => String(f.majorId) === String(group.key));
					if (fetterConfigs.length > 0) {
						// 获取第一层的需求
						const firstCondition = fetterConfigs[0].condition;
						let required = firstCondition;
						// 双巫师减1效果
						if (hasTwoWizard && firstCondition >= 4) {
							required = firstCondition - 1;
						}
						// 判断是否激活
						if (group.groups.length >= required) {
							activeOtherFetterIds.push(String(group.key));
						}
					}
				});
				
				const hasFourWizard = wizardCount >= 3 && activeOtherFetterIds.length === 1;

				// 非战斗羁绊ID
				const nonCombatFetters = ["8", "16", "30"];

				let choosefetters = [];

				allFetters.forEach(item => {
					// 处理恶魔羁绊特殊逻辑
					if (item.key === "23" && item.groups.length > 1) {
						let hasDemonHunter = allFetters.some(s => s.key === "13" && s.groups.length >= 2);
						if (!hasDemonHunter) {
							return; // 没有恶魔猎手时，多个恶魔不触发额外效果
						}
					}

					// 获取该羁绊的所有层级配置（按condition升序）
					let allLevelConfigs = this.fetters.filter(s => s.majorId == item.key).sort((a, b) => a.condition - b.condition);
					if (allLevelConfigs.length === 0) return;

					// 获取最高层级的condition作为格子总数
					let maxCondition = allLevelConfigs[allLevelConfigs.length - 1].condition;
					let chessCount = item.groups.length;

					// 获取对应的 major 信息
					let majorInfo = this.majors.find(m => String(m.id) === String(item.key));

					// 生成格子数据 - 按层级分行
					let levelRows = this.generateGridSlots(
						allLevelConfigs,
						chessCount,
						hasTwoWizard,
						hasFourWizard,
						item.key,
						nonCombatFetters,
						activeOtherFetterIds
					);

					// 兼容旧数据结构
					let gridSlots = [];
					levelRows.forEach(row => {
						gridSlots = gridSlots.concat(row.slots);
					});

					// 获取已满足的羁绊层级（原有逻辑）
					let fetters = [];
					if (hasTwoWizard && !nonCombatFetters.includes(item.key)) {
						fetters = allLevelConfigs.filter(s =>
							(s.condition >= 4 && chessCount >= s.condition - 1) ||
							(s.condition < 4 && chessCount >= s.condition)
						);
					} else {
						fetters = allLevelConfigs.filter(s => chessCount >= s.condition);
					}

					// 计算所有层级的满足状态
					let allLevels = allLevelConfigs.map(config => {
						let required = config.condition;
						// 双巫师减1效果
						if (hasTwoWizard && config.condition >= 4 && !nonCombatFetters.includes(item.key)) {
							required = config.condition - 1;
						}
						return {
							condition: config.condition,
							name: config.name,
							desc: config.desc,
							isMet: chessCount >= required
						};
					});

					let fetterSummary = {
						fetter: fetters.length > 0 ? fetters[fetters.length - 1] : allLevelConfigs[0], // 取最高级或第一个
						fetters: fetters,
						chesses: item.groups,
						// 新增字段
						majorId: item.key,
						majorName: majorInfo ? majorInfo.name : '',
						majorColor: majorInfo ? majorInfo.color : '#ccc',
						majorPhoto: majorInfo ? majorInfo.icon : '',
						chessCount: chessCount,
						gridSlots: gridSlots,
						levelRows: levelRows, // 按层级分行的格子数据
						allLevels: allLevels,
						isActive: fetters.length > 0, // 是否已激活任意层级
						maxCondition: maxCondition
					};

					choosefetters.push(fetterSummary);
				});

				// 四巫师特殊效果（解锁激活羁绊的所有层数）
				if (hasFourWizard && activeOtherFetterIds.length === 1) {
					// 只解锁那一个激活的羁绊
					const targetMajorId = activeOtherFetterIds[0];
					choosefetters.forEach(s => {
						if (String(s.majorId) !== targetMajorId) return;
						
						let allFettersForMajor = this.fetters.filter(f => String(f.majorId) == String(s.majorId));
						if (allFettersForMajor.length > 0) {
							s.fetter = allFettersForMajor[allFettersForMajor.length - 1];
							s.fetters = allFettersForMajor;
							s.isActive = true;
							// 四巫师点亮所有格子
							s.gridSlots.forEach(slot => {
								slot.isActive = true;
								slot.isHighlight = true;
							});
							// 更新 levelRows 中的格子状态
							if (s.levelRows) {
								s.levelRows.forEach(row => {
									row.isActive = true;
									row.slots.forEach(slot => {
										slot.isActive = true;
										slot.isHighlight = true;
									});
								});
							}
						}
					});
				}

				// 无面者特殊逻辑：只有当除无面者以外没有其他任何**激活的**种族/职业羁绊时，才显示无面者
				const facelessKey = "33";
				const hasFaceless = choosefetters.some(s => String(s.majorId) === facelessKey);
				if (hasFaceless) {
					// 只检查激活的其他羁绊
					const otherActiveFetters = choosefetters.filter(s => 
						String(s.majorId) !== facelessKey && s.isActive
					);
					if (otherActiveFetters.length > 0) {
						// 有其他激活的种族/职业羁绊，移除无面者
						choosefetters = choosefetters.filter(s => String(s.majorId) !== facelessKey);
					}
				}

				// 排序：已激活的羁绊靠前，同状态按majorId排序（保持位置稳定），再按数量排序
				this.choosefetters = choosefetters.sort((a, b) => {
					// 第一优先级：已激活的羁绊排前面
					if (a.isActive !== b.isActive) {
						return a.isActive ? -1 : 1;
					}
					// 第二优先级：按majorId排序，保持羁绊位置稳定
					const majorIdA = String(a.majorId || a.fetter?.majorId || 0);
					const majorIdB = String(b.majorId || b.fetter?.majorId || 0);
					if (majorIdA !== majorIdB) {
						return majorIdA.localeCompare(majorIdB);
					}
					// 第三优先级：同majorId按数量降序
					return (b.chessCount || 0) - (a.chessCount || 0);
				});
			},

			// 生成羁绊格子数据 - 按层级分行（固定3行）
			generateGridSlots(allLevelConfigs, chessCount, hasTwoWizard, hasFourWizard, majorId, nonCombatFetters, activeOtherFetterIds = []) {
				// 按层级生成行数据
				let levelRows = [];

				// 四巫师特殊处理：只点亮激活的那个羁绊的所有格子
				const isAllActive = hasFourWizard && activeOtherFetterIds.includes(String(majorId)) && !nonCombatFetters.includes(majorId);

				// 双巫师影响：第二行及之后每行减1个格子需求
				const wizardReduce = hasTwoWizard && majorId !== "9" && !nonCombatFetters.includes(majorId);

				// 固定3行布局，每行最多3个格子
				const maxRows = 3;

				for (let i = 0; i < allLevelConfigs.length; i++) {
					let config = allLevelConfigs[i];
					let condition = config.condition;

					// 计算该行需要的格子数
					let prevCondition = i > 0 ? allLevelConfigs[i - 1].condition : 0;
					let slotCount = condition - prevCondition;

					// 双巫师：第二行（中间层）减1个格子
					if (wizardReduce && i === 1) {
						slotCount = Math.max(1, slotCount - 1);
					}

					// 判断该行是否激活
					let isRowActive = false;
					if (isAllActive) {
						isRowActive = true;
					} else {
						// 计算激活该层需要的棋子数（双巫师只对condition>=4的层级减1）
						let required = condition;
						if (wizardReduce && condition >= 4) {
							required = condition - 1;
						}
						isRowActive = chessCount >= required;
					}

					// 计算该行已有点亮的格子数（用于未满足但有棋子的情况）
					let activeSlotsInRow = 0;
					if (!isRowActive && chessCount > 0) {
						// 计算当前层之前已满足的需求（考虑双巫师减1）
						let prevConditionMet = 0;
						if (i > 0) {
							let prevCondition = allLevelConfigs[i - 1].condition;
							// 双巫师只对condition>=4的层级减1
							if (wizardReduce && prevCondition >= 4) {
								prevConditionMet = prevCondition - 1;
							} else {
								prevConditionMet = prevCondition;
							}
						}
						let remainingChesses = chessCount - prevConditionMet;
						// 当前层可能点亮的格子数
						activeSlotsInRow = Math.max(0, Math.min(remainingChesses, slotCount));
					}

					// 判断是否有低层已满足（用于区分激活色和半透明红色）
					// 如果当前行未满足，但之前某行已满足，则当前行的部分格子应该用激活色而非半透明
					let hasLowerRowActive = i > 0 && levelRows.slice(0, i).some(r => r.isActive);

					let slots = [];
					for (let j = 0; j < slotCount; j++) {
						// 如果行激活，所有格子激活
						// 如果行未激活但有棋子：
						//   - 如果低层已满足，用激活色（表示向高层累积）
						//   - 如果低层未满足，用半透明红色（表示未达到任何羁绊）
						let isActive = isRowActive;
						let isPartial = false;

						if (!isRowActive && j < activeSlotsInRow) {
							if (hasLowerRowActive) {
								// 低层已满足，当前层的格子用激活色
								isActive = true;
							} else {
								// 低层未满足，用半透明红色
								isPartial = true;
							}
						}

						slots.push({
							isActive: isActive,
							isHighlight: isAllActive,
							isPartial: isPartial
						});
					}

					levelRows.push({
						condition: condition,
						slots: slots,
						isActive: isRowActive
					});
				}

				// 填充空行，确保固定3行（从顶部填充空白行）
				while (levelRows.length < maxRows) {
					levelRows.unshift({
						condition: 0,
						slots: [],
						isActive: false,
						isEmpty: true
					});
				}

				return levelRows;
			},

			// 通用分组获取羁绊
			getGroupFetters(array, field, isSingle = false) {
				let groups = {};

				array.forEach(item => {
					let values = [];

					// 特殊处理百戏大王（id=115）- 使用选择的职业
					if (item.id === 115) {
						// 获取百戏大王选择的职业
						const selectedOccs = this.ringmasterOccMap[item.id] || [];
						if (field === 'occupation' || field === 'occList') {
							values = selectedOccs;
						} else {
							// 百戏大王没有种族
							return;
						}
					} else {
						values = isSingle ? [item[field]] : (item[field] || []);
					}

					values.forEach(val => {
						if (!val) return;
						// 排除百戏大王的特殊职业（id=37）
						if (String(val) === '37') return;
						groups[val] = groups[val] || [];
						// 避免重复添加同一个棋子
						if (!groups[val].some(c => c.id === item.id)) {
							groups[val].push(item);
						}
					});
				});

				// 处理奇观轮选择的羁绊 - 为每个选中的羁绊+1计数
				this.selectedWheelFetters.forEach(fetter => {
					const fetterId = String(fetter.id);

					// 检查羁绊类型是否匹配（种族或职业）
					// type: 0 = 职业, 1 = 种族
					const isRace = fetter.type === 1;
					const isOcc = fetter.type === 0;

					if ((field === 'raceList' && isRace) || (field === 'occupation' && isOcc)) {
						// 确保分组存在（即使没有真实棋子）
						if (!groups[fetterId]) {
							groups[fetterId] = [];
						}
						// 添加一个虚拟棋子表示奇观轮的+1
						const wheelBonusChess = {
							id: 'wheel_bonus_' + fetterId + '_' + Date.now(),
							name: '奇观轮加成',
							isWheelBonus: true
						};
						groups[fetterId].push(wheelBonusChess);
					}
				});

				return Object.keys(groups).map(key => ({
					key: key,
					groups: groups[key]
				}));
			},

			// 初始化主题设置
			initTheme() {
				try {
					const savedTheme = uni.getStorageSync('darkMode');
					const autoTheme = uni.getStorageSync('autoDarkMode');

					if (autoTheme === true || autoTheme === 'true') {
						// 自动模式：根据系统设置
						this.followSystemTheme();
					} else if (savedTheme !== '') {
						this.darkMode = savedTheme === true || savedTheme === 'true';
					}
				} catch (e) {
					console.log('读取主题设置失败', e);
				}
			},

			// 跟随系统主题
			followSystemTheme() {
				// #ifdef H5
				if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
					this.darkMode = true;
				} else {
					this.darkMode = false;
				}
				// #endif

				// #ifdef MP-WEIXIN || APP-PLUS
				uni.getSystemInfo({
					success: (res) => {
						if (res.theme === 'dark') {
							this.darkMode = true;
						} else {
							this.darkMode = false;
						}
					}
				});
				// #endif
			},

			// 切换暗色模式
			toggleDarkMode() {
				console.log('toggleDarkMode called, current:', this.darkMode);
				this.darkMode = !this.darkMode;
				console.log('toggleDarkMode changed to:', this.darkMode);
				try {
					uni.setStorageSync('darkMode', this.darkMode);
					uni.setStorageSync('autoDarkMode', false);
				} catch (e) {
					console.log('保存主题设置失败', e);
				}
			},

			// 折叠/展开羁绊详情
			accordion() {
				this.fetterHidden = !this.fetterHidden;
			},

			// 切换羁绊视图模式
			toggleFetterView() {
				this.fetterViewMode = this.fetterViewMode === 'list' ? 'tile' : 'list';
			},

			// 切换全屏模式
			toggleFullscreen() {
				this.fullscreen = !this.fullscreen;
				if (this.raocTale[0] && this.raocTale[0][0] && this.raocTale[0][0].chesses[0]) {
					if (this.fullscreen) {
						this.raocTale[0][0].chesses[0].photo = "/static/fullscreen-collapse.png";
					} else {
						this.raocTale[0][0].chesses[0].photo = "/static/fullscreen-expand.png";
					}
				}
			},

			// 判断格子是否被选中
			isCellSelected(cell) {
				if (!cell || !cell.chesses || cell.chesses.length === 0) return false;
				if (cell.chesses[0].cost === 0) return false;
				return cell.chesses.some(chess =>
					this.choosePool.some(c => c.id === chess.id)
				);
			},

			// 判断多棋子格子是否有部分棋子被选中
			isCellPartialSelected(cell) {
				if (!cell || !cell.chesses || cell.chesses.length === 0) return false;
				return cell.chesses.some(chess =>
					this.choosePool.some(c => c.id === chess.id)
				);
			}
		}
	}
</script>

<style scoped>
	.main {
		display: flex;
		flex-direction: column;
	}

	.tabs-fixed {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		z-index: 1000;
		background-color: #fff;
		display: flex;
		justify-content: space-between;
		align-items: center;
		padding: 0 20rpx;
	}

	.tabs-wrapper {
		flex: 1;
	}

	.theme-toggle-global {
		width: 60rpx;
		height: 60rpx;
		display: flex;
		align-items: center;
		justify-content: center;

	}

	.main.dark-mode .theme-toggle-global {
		border-color: #fff;
	}

	.container {
		margin-top: 10rpx;
		margin-bottom: 20rpx;
		min-height: 400rpx;
		width: 100%;
	}

	/* 小黑屋样式 */
	.blackhouse {
		margin-top: 40rpx;
		padding-top: 30rpx;
		border-top: 4rpx dashed #ccc;
	}

	.blackhouse-title {
		display: flex;
		align-items: center;
		margin-bottom: 20rpx;
		padding-left: 20rpx;
	}

	.blackhouse-text {
		font-size: 32rpx;
		font-weight: bold;
		color: #666;
		margin-right: 10rpx;
	}

	.blackhouse-sub {
		font-size: 24rpx;
		color: #999;
	}

	.blackhouse-list {
		display: flex;
		flex-wrap: wrap;
		gap: 16rpx;
		padding: 0 20rpx;
	}

	.blackhouse-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 12rpx;
		border-radius: 12rpx;
		background: #f5f5f5;
		border: 2rpx solid #ddd;
		cursor: pointer;
		opacity: 0.7;
	}

	.blackhouse-item:active {
		opacity: 1;
	}

	.blackhouse-name {
		font-size: 22rpx;
		color: #999;
		margin-top: 8rpx;
		text-align: center;
	}

	/* 装备样式 */
	.items-container {
		display: flex;
		flex-direction: column;
		margin-right: 20rpx;
		padding-right: 20rpx;
	}

	.item-card {
		display: flex;
		flex-direction: row;
		align-items: center;
		width: 100%;
		padding: 10rpx 20rpx;
		margin: 10rpx 0;
		background: #ffffff;
		border-radius: 16rpx;
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.08);
		margin-bottom: 12rpx;
	}

	.item-icon {
		width: 100rpx;
		height: 100rpx;
		border-radius: 12rpx;
		margin-right: 20rpx;
		background: #f0f2f5;
		flex-shrink: 0;
	}

	.item-info {
		flex: 1;
		display: flex;
		flex-direction: column;
	}

	.item-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 8rpx;
	}

	.item-name {
		font-size: 28rpx;
		font-weight: bold;
		color: #333;
	}

	.item-level {
		font-size: 22rpx;
		padding: 4rpx 12rpx;
		border-radius: 20rpx;
		color: #fff;
	}

	.item-level.level-1 {
		background: #969797;
	}

	.item-level.level-2 {
		background: #a8a9e5;
	}

	.item-level.level-3 {
		background: #3334ce;
	}

	.item-level.level-4 {
		background: #cd01cd;
	}

	.item-level.level-5 {
		background: #e17a02;
	}

	.item-desc {
		font-size: 24rpx;
		color: #666;
		line-height: 1.4;
	}

	/* 圣物样式 */
	.relics-container {
		display: flex;
		flex-direction: column;
		gap: 20rpx;
		padding-right: 20rpx;
		margin-right: 20rpx;
	}

	.relic-card {
		display: flex;
		flex-direction: row;
		align-items: flex-start;
		width: 100%;
		padding: 20rpx;
		background: #ffffff;
		border-radius: 16rpx;
		box-shadow: 0 4rpx 16rpx rgba(0, 0, 0, 0.08);
	}

	.relic-icon {
		width: 100rpx;
		height: 100rpx;
		border-radius: 12rpx;
		margin-right: 20rpx;
		background: #f0f2f5;
		flex-shrink: 0;
	}

	.relic-info {
		flex: 1;
		display: flex;
		flex-direction: column;
	}

	.relic-name {
		font-size: 30rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 12rpx;
	}

	.relic-desc {
		font-size: 26rpx;
		color: #666;
		line-height: 1.5;
	}

	.chesslevel {
		min-height: 72rpx;
		display: flex;
		text-align: left;
		width: fit-content;
		margin: 16rpx;
	}

	.chessraoc {
		min-height: 80rpx;
		margin-top: 10rpx;
		display: flex;
		text-align: left;
		width: fit-content;
	}

	.raocchesses {
		display: flex;
		flex-wrap: wrap;
	}

	.chess {
		width: 64rpx;
		height: 64rpx;
		border-radius: 8rpx;
		box-shadow: 0 6rpx 6rpx #ebedf0;
	}

	/* 棋子样式基础类 */
	.chess-base {
		width: 64rpx;
		height: 64rpx;
		background: #6b7997;
		margin: 10rpx;
	}

	.chessline {
		border-radius: 100rpx;
		box-shadow: 0 0 0 10rpx #ebedf0;
	}

	.chesslineRaOc {
		box-shadow: 0 0 0 6rpx #0084ff28;
		margin-right: 20rpx;
	}

	.chesslineCost {
		width: 80rpx;
		margin-right: 20rpx;
		border-radius: 30rpx;
		box-shadow: 0 0 0 10rpx #ebedf0;
		color: #fff;
		display: flex;
		justify-content: center;
		align-items: center;
		text-align: center;
	}

	.cell {
		display: inline-block;
		background: #f2f3f5;
		border-radius: 8rpx;
		box-shadow: 0 6rpx 6rpx #ebedf0;
	}

	.tablechess {
		width: 32rpx;
		height: 32rpx;
		background: #7e7f80;
		border-radius: 8rpx;
	}

	.card {
		min-height: 20vh;
		margin-bottom: 40rpx;
		padding: 25rpx;
		background-color: #f2f2f7;
		box-shadow: 0 4rpx 20rpx 0 rgba(0, 0, 0, 0.08);
		border-radius: 16rpx;
		overflow: hidden;
	}

	.table-header {
		display: flex;
		justify-content: flex-end;
		margin-bottom: 20rpx;
	}

	.rotate-btn {
		padding: 10rpx 20rpx;
		background: #fff;
		border-radius: 8rpx;
		box-shadow: 0 4rpx 10rpx rgba(0, 0, 0, .1);
	}

	.table-wrapper {
		overflow: auto;
		max-height: 70vh;
	}

	.table-wrapper.fullscreen-mode {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		z-index: 9999;
		background: #f5f5f5;
		max-height: 100vh;
		padding: 20rpx;
		padding-bottom: 400rpx;
	}

	.table-container {
		display: table;
		border-collapse: separate;
		border-spacing: 6rpx;
	}

	.chesstable {
		display: table-row;
	}

	.tablecell {
		display: table-cell;
		height: 72rpx;
		width: 72rpx;
		padding: 4rpx;
		border-radius: 8rpx;
		background-color: #adc0d4;
		box-shadow: 0 4rpx 10rpx rgba(0, 0, 0, .05);
		vertical-align: middle;
		text-align: center;
		overflow: hidden;
	}

	.single-chess {
		width: 64rpx;
		height: 64rpx;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.cell-main-chess {
		width: 64rpx;
		height: 64rpx;
		border-radius: 8rpx;
	}

	.multi-chess-grid {
		display: grid;
		grid-template-columns: repeat(2, 1fr);
		grid-template-rows: repeat(2, 1fr);
		gap: 2rpx;
		width: 64rpx;
		height: 64rpx;
		position: relative;
	}

	.grid-chess {
		width: 30rpx;
		height: 30rpx;
		border-radius: 4rpx;
		object-fit: cover;
	}

	.grid-chess-selected {
		background: #1890ff !important;
		border-radius: 4rpx;
	}

	.grid-more {
		position: absolute;
		bottom: 0;
		right: 0;
		background: rgba(0, 0, 0, 0.7);
		color: #fff;
		font-size: 16rpx;
		padding: 2rpx 6rpx;
		border-radius: 4rpx;
	}

	.tablecell.fixed-col {
		position: sticky;
		left: 0;
		z-index: 10;
	}

	.tablecell.fixed-row {
		position: sticky;
		top: 0;
		z-index: 10;
	}

	.tablecell.fixed-row.fixed-col {
		z-index: 20;
	}

	.tablecell.selected-cell {
		background: #1890ff !important;
		box-shadow: 0 0 0 4rpx #40a9ff, 0 4rpx 10rpx rgba(24, 144, 255, 0.3);
	}

	.tablecell.multi-cell-selected {
		box-shadow: 0 0 0 4rpx #40a9ff, 0 4rpx 10rpx rgba(24, 144, 255, 0.3);
	}

	/* .exit-fullscreen-btn {
		position: fixed;
		top: 20rpx;
		right: 20rpx;
		z-index: 10000;
		width: 80rpx;
		height: 80rpx;
		background: rgba(0, 0, 0, 0.5);
		border-radius: 50%;
		display: flex;
		justify-content: center;
		align-items: center;
	} */

	.fettercard {
		max-height: 75vh;
		overflow-y: auto;
		padding: 10rpx;
		background-color: #f8f8f8;
		border-radius: 8rpx;
		position: relative;
	}

	.chooseCard {
		min-height: 80rpx;
		margin-bottom: 24rpx;
		padding: 20rpx;
		background-color: #fff;
		box-shadow: 0px 0px 10rpx 0 #999;
		display: flex;
		flex-direction: column;
	}

	.chooseRagne {
		min-height: 80rpx;
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		align-items: center;
		flex-wrap: nowrap;
		overflow: scroll;
	}

	.menuRagne {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		margin-bottom: 10rpx;
		margin-top: 10rpx;
		min-height: 80rpx;
	}

	.chooseItem {
		width: 64rpx !important;
		height: 64rpx !important;
		margin-left: 10rpx;
		margin-bottom: 10rpx;
		padding: 4rpx;
		display: flex;
		justify-content: center;
		align-items: center;
		border-radius: 50%;
		box-shadow: 0 6rpx 10rpx rgba(0, 0, 0, 0.15);
		color: white;
		font-weight: bold;
	}

	.chooseItem.show {
		background-color: #333333;
	}

	.chooseItem.tips {
		background-color: #40cb33;
	}

	.chooseItem.action {
		background-color: #ff4d4f;
	}

	.chooseItem.ringmaster-btn {
		background-color: #dfc36d;
	}
	
	.chooseItem.fetter-change{
		background-color: #006cff;
	}
	.chooseItem.rm_wheel{
		background-color:#e7b9ef
	}
	/* 重复模式按钮 */
	.chooseItem.repeat-mode-btn {
		background-color: #666;
		transition: all 0.3s;
	}
	.chooseItem.repeat-mode-btn.active {
		background-color: #FF8C00;
		box-shadow: 0 0 10rpx #FFD700;
	}
	/* 奇观轮已选羁绊样式（在chooseRagne中） */
	.chooseItem.wheel-fetter-item {
		position: relative;
		padding: 0;
		border-radius: 8rpx;
		display: flex;
		justify-content: center;
		align-items: center;
	}

	.wheel-badge {
		position: absolute;
		right: 2rpx;
		bottom: 2rpx;
		width: 28rpx;
		height: 28rpx;
	}

	/* 奇观轮选择面板样式 */
	.wheel-popup {
		width: 700rpx;
		max-height: 70vh;
		background: #fff;
		border-radius: 20rpx;
		overflow: hidden;
	}

	.wheel-popup-title {
		padding: 25rpx;
		text-align: center;
		font-size: 30rpx;
		font-weight: bold;
		border-bottom: 1rpx solid #eee;
	}

	/* 已选羁绊展示区 */
	.wheel-selected {
		display: flex;
		flex-wrap: wrap;
		gap: 12rpx;
		padding: 15rpx 25rpx;
		background: #f5f5f5;
		border-bottom: 1rpx solid #eee;
	}

	.wheel-selected-item {
		position: relative;
		width: 60rpx;
		height: 60rpx;
		border-radius: 8rpx;
		overflow: hidden;
	}

	.wheel-selected-item image {
		width: 100%;
		height: 100%;
	}

	.wheel-remove-icon {
		position: absolute;
		top: -2rpx;
		right: -2rpx;
		width: 28rpx;
		height: 28rpx;
		background: rgba(0, 0, 0, 0.6);
		color: white;
		border-radius: 50%;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 20rpx;
		font-weight: bold;
	}

	.wheel-popup-content {
		padding: 20rpx;
		max-height: 70vh;
		overflow-y: auto;
	}

	.wheel-section {
		margin-bottom: 25rpx;
	}

	.wheel-section-title {
		font-size: 26rpx;
		font-weight: bold;
		margin-bottom: 15rpx;
		color: #333;
	}

	.wheel-fetter-list {
		display: flex;
		flex-wrap: wrap;
		gap: 10rpx;
		margin:20rpx 0 0 20rpx;
	}

	/* 选择面板中的羁绊项 */
	.wheel-fetter-list .wheel-fetter-item {
		width: 70rpx;
		height: 80rpx;
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		border: 2rpx solid #eee;
		border-radius: 8rpx;
		padding: 4rpx;
		transition: all 0.3s;
		background: #fafafa;		
	}

	.wheel-fetter-list .wheel-fetter-item image {
		width: 60rpx;
		height: 60rpx;
	}

	.wheel-fetter-list .wheel-fetter-item text {
		font-size: 16rpx;
		margin-top: 5rpx;
		color: #666;
	}

	/* 图标容器 - 用于放置次数角标 */
	.wheel-fetter-icon-wrapper {
		position: relative;
		width: 60rpx;
		height: 60rpx;
	}

	.wheel-fetter-icon-wrapper image {
		width: 60rpx;
		height: 60rpx;
	}

	/* 次数角标 */
	.wheel-count-badge {
		position: absolute;
		right: -6rpx;
		top: -6rpx;
		min-width: 28rpx;
		height: 28rpx;
		border-radius: 14rpx;
		background: #FF4444;
		color: white;
		font-size: 18rpx;
		font-weight: bold;
		display: flex;
		align-items: center;
		justify-content: center;
		padding: 0 6rpx;
	}

	.wheel-fetter-list .wheel-fetter-item.selected {
		background: #e3f2fd;
		border-color: #2196f3;
	}

	.wheel-fetter-list .wheel-fetter-item.selected text {
		color: #2196f3;
	}

	.wheel-popup-actions {
		display: flex;
		border-top: 1rpx solid #eee;
	}

	.wheel-btn {
		flex: 1;
		border: none;
		border-radius: 0;
		font-size: 28rpx;
	}

	.wheel-btn.cancel {
		background: #f5f5f5;
		color: #666;
	}

	.wheel-btn.confirm {
		background: #2196f3;
		color: #fff;
	}

	.main.dark-mode .card{
		background-color: #121212;
	}
	
	.main.dark-mode .chooseItem {
		box-shadow: 0 6rpx 10rpx rgba(0, 0, 0, 0.4);
	}
	.main.dark-mode .ringmaster-btn {
		background-color: #d1a51f;
	}
	.main.dark-mode .chooseItem.fetter-change{
		background-color: #164a91;
	}
	.main.dark-mode .chooseItem.rm_wheel{
		background-color:#661a1a
	}
	.main.dark-mode .chooseItem.repeat-mode-btn {
		background-color: #444;
	}
	.main.dark-mode .chooseItem.repeat-mode-btn.active {
		background-color: #FF8C00;
		box-shadow: 0 0 10rpx #FFD700;
	}
	/* 奇观轮暗色模式 */
	.main.dark-mode .wheel-popup {
		background: #1e1e1e;
	}

	.main.dark-mode .wheel-popup-title {
		color: #fff;
		border-bottom-color: #333;
	}

	.main.dark-mode .wheel-selected {
		background: #1a1a1a;
		border-bottom-color: #333;
	}

	.main.dark-mode .wheel-section-title {
		color: #e0e0e0;
	}

	.main.dark-mode .wheel-fetter-list .wheel-fetter-item {
		background: #2d2d2d;
		border-color: #444;
	}

	.main.dark-mode .wheel-fetter-list .wheel-fetter-item text {
		color: #b0b0b0;
	}

	.main.dark-mode .wheel-fetter-list .wheel-fetter-item.selected {
		background: #3a1515;
		border-color: #FF4444;
	}

	.main.dark-mode .wheel-fetter-list .wheel-fetter-item.selected text {
		color: #FF6B6B;
	}

	.main.dark-mode .wheel-popup-actions {
		border-top-color: #333;
	}

	.main.dark-mode .wheel-btn.confirm {
		background:#FF4444;
		color: #fff;
	}
	.main.dark-mode .wheel-btn.cancel {
		background: #2d2d2d;
		color: #b0b0b0;
	}

	.popCellChesses {
		height: 100rpx;
		padding: 20rpx;
		display: flex;
		justify-content: space-around;
		align-items: center;
		text-align: left;
		width: 360rpx;
		border-radius: 20rpx;
	}

	.van-popup {
		border-radius: 12rpx;
	}

	.popCellChess {
		border: 4rpx;
		border-radius: 8rpx;
		display: inline-flex;
	}

	.pop-chess-selected {
		background: #1890ff !important;
	}

	.choosebg {
		background-color: #adc0d4;
		border: 1px solid #1867b1
	}

	.show {
		background-color: #000000;
	}

	.action {
		/* background-color: #6caee1; */
		background-color: #ff0000;
	}

	.tips {
		background-color: #FFD01E;
	}

	.fix {
		background-color: #000000;
	}

	.fetter {
		display: flex;
		font-size: 24rpx;
		margin-top: 20rpx;
		margin-bottom: 10rpx;
	}

	.fetterSummary {
		width: 20%;
		text-align: left;
	}

	.fetterlite {
		display: flex;
		flex-direction: row;
		flex-wrap: wrap;
		font-size: 24rpx;
		margin-left: 10rpx;
		position: relative;
	}

	.fetterName {
		margin: 6rpx;
		padding: 6rpx;
		color: #fff;
	}

	.fetterarrow {
		position: absolute;
		right: 10rpx;
		bottom: 10rpx;
		z-index: 10;
		background: rgba(255, 255, 255, 0.9);
		border-radius: 50%;
		padding: 8rpx;
		box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.15);
	}

			/* 方块格子模式样式 */
	.fettercard-tile {
		padding: 10rpx !important;
	}

	.fetterlite-scroll {
		width: 100%;
		white-space: nowrap;
	}

	.fetterlite-tile {
		display: inline-flex;
		flex-direction: row;
		flex-wrap: nowrap;
		gap: 8rpx;
		padding:4rpx 0;
		align-items: flex-end;
	}

	.fetter-tile {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: flex-end;
		padding: 4rpx 0;
		border-radius: 8rpx;
		background: rgba(255, 255, 255, 0.05);
		width: 80rpx;
		min-height: 120rpx;
		flex-shrink: 0;
	}

	.fetter-tile-grid {
		display: flex;
		flex-direction: column-reverse;
		gap: 5rpx;
		width: 70rpx;
		margin-bottom: 10rpx;
	}

	.fetter-tile-row {
		display: flex;
		flex-direction: row;
		gap: 5rpx;
		justify-content: center;
		width: 100%;
		min-height: 10rpx;
	}

	.fetter-tile-slot {
		flex: 1;
		min-width: 16rpx;
		height: 10rpx;
		border-radius: 2rpx;
		background: rgba(128, 128, 128, 0.3);
		transition: all 0.2s ease;
	}

	.fetter-tile-slot.slot-active {
		box-shadow: 0 0 4rpx rgba(0, 0, 0, 0.3);
	}

	.fetter-tile-slot.slot-partial {
		/* 红色半透明表示有棋子但未满足羁绊 */
	}

	.fetter-tile-slot.slot-highlight {
		animation: pulse 1s ease-in-out infinite;
	}

	@keyframes pulse {
		0%, 100% { opacity: 1; }
		50% { opacity: 0.7; }
	}

	.fetter-tile-info {
		display: flex;
		flex-direction: column;
		align-items: center;
		width: 100%;
	}

	.fetter-tile-icon {
		width: 70rpx;
		height: 70rpx;
		border-radius: 8rpx;
	}

	.fetter-icon-inactive {
		opacity: 0.4;
		filter: grayscale(100%);
	}

	.fetter-tile-name {
		font-size: 20rpx;
		color: #999;
		white-space: nowrap;
	}

	.fetterDetail {
		width: 100%;
		margin-left: 10rpx;
		display: flex;
		text-align: left;
		flex-direction: column;
	}

	.fetters {
		color: #1890ff;
	}

	.fetterChesses {
		margin-top: 10rpx;
		display: flex;
		flex-wrap: wrap;
		color: #c5c0c0;
	}

	.fetterChess {
		margin-right: 16rpx;
		color: #c5c0c0;
	}

	.badge-icon {
		display: block;
		font-size: 20rpx;
		line-height: 32rpx;
	}

	.badge-icon-fixed {
		position: absolute;
		top: 0rpx;
		right: 6rpx;
		width: 30rpx;
		height: 30rpx;
		border-radius: 100rpx;
		background-color: #d7c7ea;
	}

	@keyframes changes {
		0% {
			transform: translate3d(-525%, 0, 0) rotate(35deg);
		}

		50% {
			transform: translate3d(525%, 0, 0) rotate(35deg);
		}

		100% {
			transform: translate3d(525%, 0, 0) rotate(35deg);
		}
	}

	.shine {
		position: relative;
		z-index: 1;
		padding: 0.5em 1em;
		overflow: hidden;
		font-family: inherit;
		font-size: inherit;
		color: white;
		cursor: pointer;
		background-color: hsl(236, 32%, 26%);
		border: none;
		outline: none;
		width: 160rpx;
		border-radius: 10rpx;
	}

	.shine::after {
		position: absolute;
		top: -50%;
		bottom: -50%;
		z-index: -1;
		width: 1.25em;
		content: '';
		background-color: hsla(0, 0%, 100%, 0.2);
		transform: translate3d(-525%, 0, 0) rotate(35deg);
		animation: changes 3s 0.2s linear infinite;
	}

	.MySavesHeader {
		display: flex;
		flex-direction: row;

	}

	.title {
		text-align: center;
		padding: 10rpx;
		font-size: 40rpx;
		color: #353535;
		line-height: 1.8;
		font-weight: bold;
	}

	.text-box {
		margin-bottom: 10rpx;
		padding: 0 20rpx;
		display: flex;
		min-height: 300rpx;
		background-color: #FFFFFF;
		font-size: 12px;
		color: #666;
		line-height: 1.6;
		font-family: 'Times New Roman', Times, serif;
	}

	.chess-detail-scroll {
		max-height: 70vh;
		padding: 20rpx;
	}

	.chess-detail {
		width: 92%;
		padding: 10rpx;
		background: #ffffff;
		border-top-left-radius: 20rpx;
		border-top-right-radius: 20rpx;
		box-shadow: 0 -4rpx 20rpx rgba(0, 0, 0, 0.1);
	}

	.detail-header {
		display: flex;
		align-items: center;
		margin-bottom: 30rpx;
	}

	.detail-photo {
		width: 120rpx;
		height: 120rpx;
		border-radius: 16rpx;
		margin-right: 30rpx;
	}

	.detail-info {
		display: flex;
		flex-direction: column;
	}

	.detail-name-row {
		display: flex;
		align-items: center;
		margin-bottom: 10rpx;
	}

	.detail-name {
		font-size: 36rpx;
		font-weight: bold;
		color: #333;
		margin-right: 16rpx;
	}

	.detail-blackhouse-tag {
		font-size: 22rpx;
		color: #fff;
		background: #999;
		padding: 4rpx 12rpx;
		border-radius: 8rpx;
	}

	.detail-cost {
		font-size: 28rpx;
		font-weight: bold;
		margin-bottom: 10rpx;
	}

	.detail-tags {
		display: flex;
		flex-direction: row;
	}

	.detail-tag {
		font-size: 24rpx;
		color: #fff;
		background: #6b7997;
		padding: 6rpx 16rpx;
		border-radius: 20rpx;
		margin-right: 10rpx;
	}

	.detail-tag-icon {
		width: 48rpx;
		height: 48rpx;
		border-radius: 8rpx;
		margin-right: 10rpx;
		background: #f5f5f5;
		padding: 4rpx;
	}

	.detail-tag-icon.clickable {
		cursor: pointer;
		transition: transform 0.2s;
	}

	.detail-tag-icon.clickable:active {
		transform: scale(0.95);
	}

	.detail-tag-icon image {
		width: 100%;
		height: 100%;
	}

	/* 种族/职业详情样式 */
	.major-detail {
		margin-top: 20rpx;
		padding: 20rpx;
		background: #f8f8f8;
		border-radius: 12rpx;
		border-left: 4rpx solid #9370db;
	}

	.major-header {
		display: flex;
		align-items: center;
		margin-bottom: 16rpx;
	}

	.major-icon {
		width: 64rpx;
		height: 64rpx;
		border-radius: 12rpx;
		margin-right: 16rpx;
		background: #fff;
		padding: 4rpx;
	}

	.major-info {
		display: flex;
		flex-direction: column;
	}

	.major-name {
		font-size: 32rpx;
		font-weight: bold;
		margin-bottom: 4rpx;
	}

	.major-type {
		font-size: 24rpx;
		color: #999;
	}

	.major-desc {
		font-size: 26rpx;
		color: #666;
		line-height: 1.6;
		margin-bottom: 16rpx;
	}

	.major-fetters {
		background: #fff;
		padding: 16rpx;
		border-radius: 8rpx;
	}

	.fetters-title {
		font-size: 28rpx;
		font-weight: bold;
		color: #333;
		display: block;
		margin-bottom: 12rpx;
	}

	.fetter-item {
		display: flex;
		flex-direction: column;
		margin-bottom: 10rpx;
		padding-bottom: 10rpx;
		border-bottom: 1rpx solid #eee;
	}

	.fetter-item:last-child {
		border-bottom: none;
		margin-bottom: 0;
		padding-bottom: 0;
	}

	.fetter-condition {
		color: #1890ff;
	}

	.fetter-desc {
		font-size: 24rpx;
		color: #666;
	}

	/* 种族/职业包含的棋子 */
	.major-chesses {
		margin-top: 20rpx;
		padding-top: 20rpx;
		border-top: 2rpx solid #eee;
	}

	.chesses-title {
		font-size: 28rpx;
		font-weight: bold;
		color: #333;
		display: block;
		margin-bottom: 16rpx;
	}

	.chesses-list {
		display: flex;
		flex-wrap: wrap;
		gap: 10rpx;
	}

	.chess-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		padding: 6rpx;
		border-radius: 8rpx;
		background: #fff;
		border: 2rpx solid #eee;
		min-width: 70rpx;
		position: relative;
		cursor: pointer;
		transition: transform 0.2s;
	}

	.chess-item:active {
		transform: scale(0.95);
	}

	.chess-item image {
		width: 44rpx;
		height: 44rpx;
		border-radius: 6rpx;
		margin-bottom: 4rpx;
	}

	.chess-item .chess-name {
		font-size: 18rpx;
		color: #666;
		text-align: center;
		line-height: 1.2;
	}

	.chess-item.current-chess {
		background: #e6f7ff;
		border-color: #1890ff;
		box-shadow: 0 0 0 2rpx #1890ff;
	}

	.chess-item.current-chess .chess-name {
		color: #1890ff;
		font-weight: bold;
	}

	.current-tag {
		position: absolute;
		top: -6rpx;
		right: -6rpx;
		background: #ff4d4f;
		color: #fff;
		font-size: 16rpx;
		padding: 1rpx 6rpx;
		border-radius: 8rpx;
	}

	/* 已选中的棋子标记 */
	.chess-item.in-pool {
		background: #e6f7ff;
		border-color: #4a90e2;
	}

	.chess-item.in-pool .chess-name {
		color: #4a90e2;
		font-weight: bold;
	}

	.pool-check {
		position: absolute;
		top: -6rpx;
		left: -6rpx;
		width: 28rpx;
		height: 28rpx;
		background: #52c41a;
		color: #fff;
		font-size: 18rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		border-radius: 50%;
		font-weight: bold;
	}

	/* 百戏大王样式 */
	.ringmaster-tags {
		display: flex;
		align-items: center;
	}

	.ringmaster-hint {
		font-size: 24rpx;
		color: #9370db;
		font-style: italic;
	}

	.ringmaster-occ {
		margin-top: 20rpx;
		padding: 20rpx;
		background: #f8f8f8;
		border-radius: 12rpx;
	}

	.ringmaster-title {
		font-size: 28rpx;
		font-weight: bold;
		color: #333;
		display: block;
		margin-bottom: 16rpx;
	}

	.ringmaster-occ-list {
		display: flex;
		flex-wrap: wrap;
		gap: 12rpx;
	}

	.ringmaster-occ-item {
		width: 64rpx;
		height: 64rpx;
		border-radius: 8rpx;
		background: #fff;
		border: 2rpx solid #ddd;
		display: flex;
		justify-content: center;
		align-items: center;
		cursor: pointer;
		transition: all 0.2s;
	}

	.ringmaster-occ-item image {
		width: 48rpx;
		height: 48rpx;
	}

	.ringmaster-occ-item.selected {
		border-color: #1890ff;
		background: #e6f7ff;
		box-shadow: 0 0 0 2rpx #1890ff;
	}

	.ringmaster-count {
		font-size: 24rpx;
		color: #666;
		margin-top: 16rpx;
		display: block;
		text-align: center;
	}

	.detail-skill {
		display: flex;
		flex-direction: column;
		background: #f5f5f5;
		padding: 20rpx;
		border-radius: 12rpx;
	}

	.skill-title {
		font-size: 28rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 10rpx;
	}

	.skill-desc {
		font-size: 26rpx;
		color: #666;
		line-height: 1.6;
		margin-bottom: 10rpx;
	}

	.skill-type-section {
		display: flex;
		flex-direction: column;
		margin-top: 10rpx;
	}

	.skill-type {
		font-size: 24rpx;
		color: #666;
		font-weight: bold;
	}

	.skill-type-desc {
		font-size: 22rpx;
		color: #999;
		margin-top: 6rpx;
		line-height: 1.4;
	}

	.detail-actions {
		padding: 20rpx 30rpx 30rpx;
		text-align: center;
		background: #fff;
		border-bottom-left-radius: 20rpx;
		border-bottom-right-radius: 20rpx;
	}

	.add-btn {
		width: 100%;
		height: 80rpx;
		line-height: 80rpx;
		background: #4a90e2;
		color: #fff;
		border-radius: 40rpx;
		font-size: 30rpx;
		border: none;
	}

	.uni-padding-wrap {
		padding: 30rpx;
		width: 600rpx;
		border-radius: 20rpx;
	}

	.remove-btn {
		width: 100%;
		height: 80rpx;
		line-height: 80rpx;
		background: #ff4d4f;
		color: #fff;
		border-radius: 40rpx;
		font-size: 30rpx;
		border: none;
	}

	/* 确认弹窗样式 */
	.confirm-dialog {
		width: 560rpx;
		padding: 40rpx;
		background: #fff;
		border-radius: 20rpx;
	}

	.confirm-title {
		font-size: 36rpx;
		font-weight: bold;
		color: #333;
		text-align: center;
		margin-bottom: 20rpx;
	}

	.confirm-content {
		font-size: 30rpx;
		color: #666;
		text-align: center;
		margin-bottom: 40rpx;
		line-height: 1.6;
	}

	.confirm-actions {
		display: flex;
		flex-direction: row;
		justify-content: space-between;
		gap: 20rpx;
	}

	.confirm-btn {
		flex: 1;
		height: 80rpx;
		line-height: 80rpx;
		border-radius: 40rpx;
		font-size: 30rpx;
		border: none;
	}

	.confirm-btn.cancel {
		background: #f5f5f5;
		color: #666;
	}

	.confirm-btn.confirm {
		background: #ff4d4f;
		color: #fff;
	}

	/* 暗色模式样式 */
	.main {
		background-color: #f5f5f5;
		min-height: 100vh;
		transition: background-color 0.3s ease;
	}

	.main.dark-mode {
		background-color: #000000;
	}

	/* 暗色模式全局背景覆盖 */
	.main.dark-mode view,
	.main.dark-mode scroll-view {
		background-color: transparent;
	}

	.main.dark-mode .tabs-fixed {
		background-color: #121212;
		border-bottom: 1rpx solid #333333;
	}

	/* 备选方案 - 直接作用于u-tabs组件 */
	.main.dark-mode>>>.u-tabs__wrapper__nav__item__text {
		color: #999999 !important;
	}

	.main.dark-mode>>>.u-tabs__wrapper__nav__item--active .u-tabs__wrapper__nav__item__text {
		color: #FF4444 !important;
	}

	.main.dark-mode .chooseCard {
		background-color: #1a1a1a;
		border: 1px solid #000;
	}

	.main.dark-mode .fettercard {
		background-color: #121212;
	}

	.main.dark-mode .fetterName {
		color: #fff;
	}

	.main.dark-mode .fetterarrow {
		background: rgba(50, 50, 50, 0.9);
	}

	.main.dark-mode .fetterDetail {
		background-color: #121212;
		border-left: 4rpx solid #FF4444;
	}

	.main.dark-mode .fetters {
		color: #FF4444;
	}

	.main.dark-mode .fetterChess text {
		color: #cccccc;
	}

			/* 方块格子模式暗色样式 */
	.main.dark-mode .fetter-tile {
		background: rgba(255, 255, 255, 0.03);
	}

	.main.dark-mode .fetter-tile-slot.slot-active {
		box-shadow: 0 0 4rpx rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .fetter-icon-inactive {
		opacity: 0.4;
		filter: grayscale(100%);
	}

	.main.dark-mode .fetter-tile-name {
		color: #888;
	}

	.main.dark-mode .chooseItem.tips {
		background-color: #2a6603;
	}

	.main.dark-mode .chooseItem.action {
		background-color: #CC3333;
	}

	.main.dark-mode .choosebg {
		background-color: #1a1a1a;
		border: 2rpx solid #FF4444;
	}

	.main.dark-mode .card {
		background-color: #121212;
	}

	/* 小黑屋暗色模式样式 */
	.main.dark-mode .blackhouse {
		border-top-color: #333333;
	}

	.main.dark-mode .blackhouse-text {
		color: #999999;
	}

	.main.dark-mode .blackhouse-sub {
		color: #666666;
	}

	.main.dark-mode .blackhouse-item {
		background: #1a1a1a;
		border-color: #333333;
	}

	.main.dark-mode .blackhouse-name {
		color: #666666;
	}

	.main.dark-mode .chesslevel {
		background-color: #121212;
	}

	.main.dark-mode .chesslineCost {
		background-color: #333333 !important;
		color: #fff;
	}

	.main.dark-mode .chessline,
	.main.dark-mode .chesslineRaOc {
		background-color: #1a1a1a;
		border: 2rpx solid #333333;
	}

	.main.dark-mode .table-wrapper {
		background-color: #000000;
	}

	.main.dark-mode .table-wrapper.fullscreen-mode {
		background: #000000;
	}

	.main.dark-mode .tablecell {
		background-color: #1a1a1a;
		border: 1rpx solid #333333;
	}

	.main.dark-mode .tablecell.fixed-row,
	.main.dark-mode .tablecell.fixed-col {
		background-color: #333333;
	}

	.main.dark-mode .grid-chess {
		background-color: #121212;
	}

	/* 装备暗色模式样式 */
	.main.dark-mode .item-card {
		background: #1a1a1a;
		box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .item-icon {
		background: #121212;
	}

	.main.dark-mode .item-name {
		color: #ffffff;
	}

	.main.dark-mode .item-desc {
		color: #999999;
	}

	/* 圣物暗色模式样式 */
	.main.dark-mode .relic-card {
		background: #1a1a1a;
		box-shadow: 0 4rpx 12rpx rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .relic-icon {
		background: #121212;
	}

	.main.dark-mode .relic-name {
		color: #ffffff;
	}

	.main.dark-mode .relic-desc {
		color: #999999;
	}

	.main.dark-mode .grid-chess-selected {
		background: #FF4444 !important;
	}

	.main.dark-mode .tablecell.multi-cell-selected {
		box-shadow: 0 0 0 4rpx #FF4444, 0 4rpx 10rpx rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .grid-more {
		color: #ffffff;
		background-color: #333333;
	}

	.main.dark-mode .item-icon {
		background: #121212;
	}

	.main.dark-mode .item-name {
		color: #ffffff;
	}

	.main.dark-mode .item-desc {
		color: #999999;
	}

	/* 羁绊tab选中状态 */
	.main.dark-mode .tablecell.selected-cell {
		background: #3a1515 !important;
		box-shadow: 0 0 0 4rpx #FF4444, 0 4rpx 10rpx rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .item-name {
		color: #ffffff;
	}

	.main.dark-mode .item-desc {
		color: #c0c0c0;
	}

	/* 羁绊tab选中状态 */
	.main.dark-mode .grid-chess-selected {
		background: #FF4444 !important;
	}

	.main.dark-mode .tablecell.multi-cell-selected {
		box-shadow: 0 0 0 4rpx #FF4444, 0 4rpx 10rpx rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .grid-more {
		color: #ffffff;
		background-color: #333333;
	}

	.main.dark-mode .chess-detail,
	.main.dark-mode .detail-actions {
		background: #121212;
		border: 1rpx solid #333333;
	}

	.main.dark-mode .chess-detail-scroll {
		background-color: #121212;
	}

	.main.dark-mode .add-btn {
		background: #CC3333;
	}

	.main.dark-mode .remove-btn {
		background: #993333;
	}

	.main.dark-mode .detail-name {
		color: #ffffff;
	}

	.main.dark-mode .detail-blackhouse-tag {
		background: #333333;
	}

	.main.dark-mode .detail-tag-icon {
		background: #333333;
	}

	/* 种族/职业详情暗色模式样式 */
	.main.dark-mode .major-detail {
		background: #121212;
		border-left-color: #FF4444;
	}

	.main.dark-mode .major-icon {
		background: #1a1a1a;
	}

	.main.dark-mode .major-name {
		color: #ffffff;
	}

	.main.dark-mode .major-type {
		color: #999999;
	}

	.main.dark-mode .major-desc,
	.main.dark-mode .fetter-desc {
		color: #999999;
	}

	.main.dark-mode .major-fetters {
		background: #1a1a1a;
	}

	.main.dark-mode .fetters-title,
	.main.dark-mode .chesses-title {
		color: #ffffff;
	}

	.main.dark-mode .fetter-item {
		border-bottom-color: #333333;
	}

	.main.dark-mode .fetter-condition {
		color: #FF6666;
	}

	/* 棋子列表暗色模式样式 */
	.main.dark-mode .major-chesses {
		border-top-color: #333333;
	}

	.main.dark-mode .chess-item {
		background: #1a1a1a;
		border-color: #333333;
	}

	.main.dark-mode .chess-item .chess-name {
		color: #999999;
	}

	.main.dark-mode .chess-item.current-chess {
		background: #3a1515;
		border-color: #FF4444;
		box-shadow: 0 0 0 3rpx #FF4444;
	}

	.main.dark-mode .chess-item.current-chess .chess-name {
		color: #FF6666;
	}

	.main.dark-mode .chess-item.in-pool {
		background: #2a1a1a;
		border-color: #FF4444;
	}

	.main.dark-mode .chess-item.in-pool .chess-name {
		color: #FF6666;
	}

	.main.dark-mode .pool-check {
		background: #CC3333;
		color: #ffffff;
	}
	.main.dark-mode .help-title {
		color: #ffffff;
	}
	/* 百戏大王暗色模式样式 */
	.main.dark-mode .ringmaster-hint {
		color: #FF6666;
	}

	.main.dark-mode .ringmaster-occ {
		background: #121212;
	}

	.main.dark-mode .ringmaster-title {
		color: #ffffff;
	}

	.main.dark-mode .ringmaster-occ-item {
		background: #1a1a1a;
		border-color: #333333;
	}

	.main.dark-mode .ringmaster-occ-item.selected {
		border-color: #FF4444;
		background: #3a1515;
		box-shadow: 0 0 0 2rpx #FF4444;
	}

	.main.dark-mode .ringmaster-count {
		color: #999999;
	}

	.main.dark-mode .detail-skill {
		background: #1a1a1a;
	}

	.main.dark-mode .skill-title {
		color: #ffffff;
	}

	.main.dark-mode .skill-desc {
		color: #cccccc;
	}

	.main.dark-mode .skill-type {
		color: #999999;
	}

	.main.dark-mode .skill-type-desc {
		color: #666666;
	}

	.main.dark-mode .u-popup__content {
		background-color: #121212 !important;
	}

	.main.dark-mode .u-popup__mask {
		background-color: rgba(0, 0, 0, 0.7) !important;
	}

	.main.dark-mode .u-popup--round__content {
		background-color: #121212 !important;
	}

	.main.dark-mode .u-popup__close--hover {
		background-color: #333333 !important;
	}

	.main.dark-mode .u-popup__round__content {
		background-color: #121212 !important;
		border-radius: 20rpx;
	}

	.main.dark-mode .u-popup-top .u-popup__content {
		background-color: #121212 !important;
	}

	.main.dark-mode .u-popup-center .u-popup__content {
		background-color: #121212 !important;
	}

	/* 弹出面板暗色模式 */
	.main.dark-mode .popCellChesses {
		background-color: #333;

	}

	.main.dark-mode .popCellChess {
		background-color: #1a1a1a;
		border: 2rpx solid #333333;
	}

	.main.dark-mode .pop-chess-selected {
		background: #FF4444 !important;
	}

	.main.dark-mode .MySavesHeader {
		background-color: #121212;
	}

	.main.dark-mode .shine {
		color: #fff;
	}

	.main.dark-mode .text-box {
		background-color: #1a1a1a;
	}

	.main.dark-mode .title {
		color: #ffffff;
	}

	.main.dark-mode .uni-common-mt {
		background-color: #121212;
	}

	/* 确认弹窗暗色模式 */
	.main.dark-mode .confirm-dialog {
		background: #121212;
	}

	.main.dark-mode .confirm-title {
		color: #ffffff;
	}

	.main.dark-mode .confirm-content {
		color: #cccccc;
	}


	.main.dark-mode .confirm-btn.cancel {
		background: #333333;
		color: #cccccc;
	}

	.main.dark-mode .confirm-btn.confirm {
		background: #CC3333;
		color: #fff;
	}

	/* 过渡动画 */
	.main,
	.main .chooseCard,
	.main .fettercard,
	.main .card,
	.main .chessline,
	.main .tablecell,
	.main .chess-detail,
	.main .detail-skill {
		transition: background-color 0.3s ease, border-color 0.3s ease;
	}

	/* 熊猫模拟器样式 */
	.panda-card {
		padding: 20rpx;
		padding-bottom: 120rpx;
		position: relative;
		overflow-x: hidden;
	}

	/* 响应式布局容器 */
	.panda-main-content {
		display: flex;
		flex-direction: column;
		gap: 20rpx;
	}

	.panda-left-column {
		display: flex;
		flex-direction: column;
	}

	.panda-right-column {
		display: flex;
		flex-direction: column;
	}

	/* 宽屏适配：两列布局 */
	@media (min-width: 750px) {
		.panda-main-content {
			flex-direction: row;
			gap: 30rpx;
			align-items: stretch;
		}

		.panda-left-column {
			flex: 1;
			min-width: 0;
		}

		.panda-right-column {
			flex: 1;
			min-width: 0;
			display: flex;
			flex-direction: column;
			align-items: stretch;
		}

		.panda-right-column .panda-status {
			flex: 1;
			display: flex;
			flex-direction: column;
			min-height: 0;
			max-height: none;
			height: auto;
		}

		.panda-right-column .panda-status .status-scroll {
			flex: 1;
			min-height: 400rpx;
		}
	}

	.panda-footer {
		position: fixed;
		bottom: 10rpx;
		left: 30rpx;
		right: 30rpx;
		z-index: 100;
	}

	.panda-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 20rpx;
	}

	.round-info {
		font-size: 32rpx;
		font-weight: bold;
		color: #333;
	}

	.panda-controls {
		display: flex;
		align-items: center;
		gap: 15rpx;
	}

	.panda-options {
		display: flex;
		gap: 30rpx;
		margin-bottom: 25rpx;
	}

	.option-item {
		display: flex;
		align-items: center;
		gap: 10rpx;
		font-size: 24rpx;
		color: #666;
	}

	.status-row {
		display: flex;
		justify-content: space-between;
		font-size: 24rpx;
		color: #999;
		margin-bottom: 10rpx;
	}

	.status-text {
		text-align: center;
		font-size: 26rpx;
		color: #666;
	}

	.continue-btn {
		margin-top: 20rpx;
	}

	.popup-panda.small {
		width: 100rpx;
		height: 100rpx;
		margin: 0 auto 20rpx;
		position: relative;
	}

	.menu-btns {
		display: flex;
		gap: 20rpx;
		justify-content: center;
		margin-bottom: 20rpx;
		flex-wrap: wrap;
	}

	.menu-btn-group {
		display: flex;
		gap: 10rpx;
	}

	.sell-btn {
		background: #999 !important;
		color: #fff !important;
	}

	.star-display {
		color: #FFD700;
		font-size: 36rpx;
	}

	.menu-close {
		position: absolute;
		top: 20rpx;
		right: 20rpx;
		font-size: 36rpx;
		color: #999;
		cursor: pointer;
	}

	.panda-menu-popup {
		position: relative;
	}

	.defense-toggle {
		display: flex;
		align-items: center;
		gap: 8rpx;
		font-size: 24rpx;
		color: #666;
	}

	.panda-board {
		margin-bottom: 20rpx;
	}

	.board-title,
	.bench-title {
		font-size: 26rpx;
		color: #666;
		margin-bottom: 10rpx;
		width: 50%
	}
	.board-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
		margin-bottom: 10rpx;
	}
	.board-btn {
		color: #1890ff;
		font-size: 24rpx;
	}
	.bench-in-btn{
		color:#FF4444 !important;
		font-size:24rpx
	}
	.bench-btns {
		display: flex;
		gap: 10rpx;
	}
	.bench-btn {
		color: #1890ff;
		font-size: 24rpx;
	}
	.bench-header {
		display: flex;
		justify-content: space-between;
		align-items: center;
	}

	.board-area {
		margin-bottom: 20rpx;
		padding: 16rpx;
		box-shadow: 0 0 8rpx #ccc;
		border-radius: 20rpx;
		background-color: #fff;
	}

	.board-card {
		background: #f5f5f5;
		border-radius: 12rpx;
	}

	.board-slots {
		display: grid;
		grid-template-columns: repeat(8, 1fr);
		gap: 8rpx;
	}

	.board-slot {
		width: 100%;
		aspect-ratio: 1;
		border-radius: 8rpx;
		display: flex;
		align-items: center;
		justify-content: center;
	}

	.board-slot.cell-white {
		background: #aab7c4;
	}

	.board-slot.cell-black {
		background: #8bafd4;
	}

	.panda-piece {
		width: 90%;
		height: 90%;
		position: relative;
	}

	.panda-piece image {
		width: 100%;
		height: 100%;
	}

	.panda-piece.star-2 {
		filter: drop-shadow(0 0 4rpx #FFD700);
	}

	.panda-piece.star-3 {
		filter: drop-shadow(0 0 8rpx #FF6B6B);
	}

	.charm-badge {
		position: absolute;
		top: -8rpx;
		right: -8rpx;
		width: 32rpx;
		height: 32rpx;
	}

	.charm-badge .charm-img {
		width: 100% !important;
		height: 100% !important;
	}

	.charm-badge-icon .charm-img {
		width: 24rpx;
		height: 24rpx;
	}

	.popup-charm .charm-img {
		width: 80rpx;
		height: 80rpx;
	}

	.bench-area {
		margin-bottom: 20rpx;
		padding: 16rpx;
		box-shadow: 0 0 8rpx #ccc;
		border-radius: 20rpx;
		background-color: #fff;
	}

	.bench-card {
		background: #fff;
		border-radius: 12rpx;
		padding: 15rpx;
	}

	.bench-slots {
		display: flex;
		gap: 8rpx;
		flex-wrap: nowrap;
	}

	.bench-slot {
		flex: 1;
		min-width: 50rpx;
		aspect-ratio: 1;
		background: #e8e8e8;
		border-radius: 8rpx;
		display: flex;
		align-items: center;
		justify-content: center;
		flex-shrink: 0;
	}

	.panda-piece.small {
		width: 90%;
		height: 90%;
	}

	.piece-star {
		position: absolute;
		bottom: 2rpx;
		right: 2rpx;
		font-size: 18rpx;
		color: #FFD700;
		text-shadow: 1rpx 1rpx 2rpx #000;
	}

	.piece-star-mini {
		position: absolute;
		bottom: 0;
		right: 0;
		font-size: 14rpx;
		color: #FFD700;
		text-shadow: 1rpx 1rpx 1rpx #000;
	}

	.charm-badge-mini {
		position: absolute;
		top: -4rpx;
		right: -4rpx;
		width: 24rpx;
		height: 24rpx;
	}

	.charm-img-mini {
		width: 100% !important;
		height: 100% !important;
	}

	.charm-display {
		display: flex;
		align-items: center;
		justify-content: center;
		margin-bottom: 20rpx;
		font-size: 28rpx;
		color: #666;
	}

	.backpack-area {
		margin-bottom: 20rpx;
		padding: 15rpx;
		background: #fff;
		box-shadow: 0 0 8rpx #ccc;
		border-radius: 20rpx;
		overflow: hidden;
	}

	.backpack-title {
		font-size: 26rpx;
		color: #666;
		margin-bottom: 10rpx;
	}

	.backpack-charms {
		display: flex;
		gap: 8rpx;
		flex-wrap: nowrap;
		padding: 14rpx;
	}

	.backpack-charm {
		flex: 1;
		min-width: 50rpx;
		height: 70rpx;
		border-radius: 8rpx;
		overflow: hidden;
		flex-shrink: 0;
	}

	.backpack-charm.empty {
		background: #e8e8e8;
		border: 2rpx dashed #ccc;
	}

	.backpack-charm image {
		width: 100%;
		height: 100%;
	}

	.charm-count {
		color: #1890ff;
		font-weight: bold;
	}

	.panda-status {
		text-align: left;
		font-size: 26rpx;
		color: #999;
		padding: 15rpx;
		background: #fff;
		box-shadow: 0 0 8rpx #ccc;
		border-radius: 20rpx;
		overflow: hidden;
		display: flex;
		flex-direction: column;
		min-height: 200rpx;
		max-height: 650rpx;
		height: auto;
	}

	.panda-status .status-scroll {
		height: 250rpx;
		border: 1rpx #999 solid;
		border-radius: 10rpx;
	}

	.panda-status .status-title {
		flex-shrink: 0;
	}

	.status-title {
		font-size: 26rpx;
		color: #999;
		margin-bottom: 10rpx;
	}

	.status-title-row {
		display: flex;
		justify-content: space-between;
		align-items: center;
		flex-shrink: 0;
	}

	.log-filter-dots {
		display: flex;
		gap: 25rpx;
		align-items: center;
	}

	.filter-dot {
		width: 24rpx;
		height: 24rpx;
		border-radius: 50%;
		cursor: pointer;
		opacity: 0.1;
		transition: opacity 0.2s;
		flex-shrink: 0;
		border: 2rpx solid #fff;
		box-sizing: border-box;
	}

	.filter-dot.active {
		opacity: 1;
	}

	.filter-dot.info {
		background-color: #999 !important;
		box-shadow: 0 0 8rpx #999;
	}

	.filter-dot.error {
		background-color: #ff4d4f !important;
		box-shadow: 0 0 8rpx #ff4d4f;
	}

	.filter-dot.combine {
		background-color: #66b3ff !important;
		box-shadow: 0 0 8rpx #66b3ff;
	}

	.filter-dot.charm {
		background-color: #fa8c16 !important;
		box-shadow: 0 0 8rpx #fa8c16;
	}

	.filter-dot.sell {
		background-color: #722ed1 !important;
		box-shadow: 0 0 8rpx #722ed1;
	}

	.status-log-empty {
		color: #999;
		font-size: 28rpx;
		text-align: center;
		padding: 20rpx;
	}

	.panda-counts {
		display: flex;
		justify-content: space-around;
		padding: 10rpx 0;
	}

	.panda-count-item {
		display: flex;
		flex-direction: column;
		align-items: center;
		font-size: 20rpx;
	}

	.panda-count-item .count-num {
		font-size: 26rpx;
		color: #999999;
		font-weight: bold;
	}

	.panda-count-item .drop-rate {
		font-size: 18rpx;
		color: #ff6b6b;
		margin-top: 2rpx;
	}

	.panda-icon {
		width: 36rpx;
		height: 36rpx;
	}

	.status-current {
		color: #1890ff;
		font-size: 24rpx;
		padding: 8rpx;
		background: #e6f7ff;
		border-radius: 6rpx;
		margin-bottom: 10rpx;
	}

	.status-log {
		color: #999;
		font-size: 24rpx;
		padding: 4rpx 0;
		text-align: left;
		margin:2rpx 16rpx;
	}

	.status-log.log-info {
		color: #999;
	}

	.status-log.log-error {
		color: #ff4d4f;
		font-weight: bold;
	}

	.status-log.log-charm {
		color: #fa8c16;
		font-weight: bold;
	}

	.status-log.log-combine {
		color: #66b3ff;
		font-weight: bold;
	}

	.status-log.log-sell {
		color: #722ed1;
	}

	/* 弹窗样式 */
	.panda-popup-overlay {
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		bottom: 0;
		background: rgba(0, 0, 0, 0.6);
		display: flex;
		align-items: center;
		justify-content: center;
		z-index: 9999;
	}

	.panda-popup {
		background: #fff;
		border-radius: 20rpx;
		padding: 40rpx;
		width: 70%;
		text-align: center;
	}

	.panda-popup.small {
		width: 50%;
		padding: 30rpx;
	}

	.panda-popup.help-popup {
		width: 80%;
		max-height: 80vh;
		overflow-y: auto;
		padding: 30rpx;
		border: 2rpx solid #fff
	}

	.panda-popup.reset-popup {
		width: 70%;
		padding: 40rpx;
	}

	.reset-content {
		color: #666;
		font-size: 28rpx;
		margin: 30rpx 0;
		text-align: center;
	}

	.help-title {
		font-size: 32rpx;
		font-weight: bold;
		color: #353535;
		margin-bottom: 20rpx;
		text-align: center;
	}

	.help-content {
		text-align: left;
	}

	.help-section {
		margin-bottom: 20rpx;
	}

	.help-section-title {
		font-size: 28rpx;
		font-weight: bold;
		color: #1890ff;
		margin-bottom: 10rpx;
	}

	.help-text {
		font-size: 24rpx;
		color: #666;
		line-height: 1.6;
		margin-left: 10rpx;
	}

	.popup-title {
		font-size: 36rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 30rpx;
	}

	.source-card {
		color: #1890ff;
	}

	.source-drop {
		color: #52c41a;
	}

	.summary-popup {
		max-height: 80vh;
		overflow-y: auto;
	}

	.summary-content {
		margin-bottom: 20rpx;
	}

	.summary-header {
		display: flex;
		padding: 15rpx 0;
		border-bottom: 2rpx solid #eee;
		font-weight: bold;
	}

	.summary-row {
		display: flex;
		padding: 15rpx 0;
		border-bottom: 1rpx solid #f0f0f0;
		align-items: center;
	}

	.summary-total {
		display: flex;
		padding: 15rpx 0;
		font-weight: bold;
		background: #f5f5f5;
		margin-top: 10rpx;
	}

	.summary-col {
		flex: 1;
		text-align: center;
		font-size: 28rpx;
		min-width: 0;
	}

	.panda-name {
		display: flex;
		align-items: center;
		justify-content: center;
		gap: 10rpx;
		font-size: 24rpx;
	}

	.summary-img {
		width: 40rpx;
		height: 40rpx;
	}

	.popup-panda {
		width: 160rpx;
		height: 160rpx;
		margin: 0 auto 20rpx;
	}

	.popup-panda image {
		width: 100%;
		height: 100%;
	}

	.popup-charm {
		font-size: 100rpx;
		margin-bottom: 20rpx;
	}

	.popup-name {
		font-size: 30rpx;
		font-weight: bold;
		color: #333;
		margin-bottom: 15rpx;
	}

	.popup-dialog {
		font-size: 26rpx;
		color: #666;
		margin-bottom: 30rpx;
		font-style: italic;
	}

	.popup-desc {
		font-size: 26rpx;
		color: #999;
		margin-bottom: 30rpx;
	}

	.popup-btns {
		display: flex;
		gap: 20rpx;
		justify-content: center;
	}

	.popup-btns .u-button {
		display: flex;
		align-items: center;
		gap: 8rpx;
	}

	.icon-text {
		font-size: 32rpx;
	}

	.drop-popup {
		width: 80%;
	}

	.dropped-pandas {
		display: flex;
		flex-wrap: wrap;
		gap: 20rpx;
		justify-content: center;
		margin-bottom: 30rpx;
	}

	.dropped-panda {
		display: flex;
		flex-direction: column;
		align-items: center;
		width: 120rpx;
	}

	.dropped-panda image {
		width: 100rpx;
		height: 100rpx;
		border-radius: 12rpx;
	}

	.dropped-star {
		font-size: 24rpx;
		color: #FFD700;
		font-weight: bold;
		margin-top: 5rpx;
	}

	.dropped-name {
		font-size: 22rpx;
		color: #666;
		margin-top: 5rpx;
	}

	.dropped-dialog {
		font-size: 20rpx;
		color: #999;
		margin-top: 5rpx;
	}

	.charm-select {
		display: flex;
		gap: 20rpx;
		justify-content: center;
		flex-wrap: wrap;
	}

	.charm-options {
		margin: 20rpx 0;
	}

	.charm-option-group {
		margin-bottom: 15rpx;
	}

	.charm-option-group .option-title {
		font-size: 24rpx;
		color: #666;
		margin-bottom: 8rpx;
		text-align: left;
	}

	.charm-option-group .no-panda {
		font-size: 22rpx;
		color: #999;
	}

	.charm-option {
		width: 100rpx;
		height: 100rpx;
		border: 2rpx solid #ddd;
		border-radius: 12rpx;
		overflow: hidden;
		position: relative;
	}

	.charm-option.selected {
		border-color: #ff4d4f;
		box-shadow: 0 0 0 4rpx #ff4d4f;
	}

	.charm-option.disabled {
		opacity: 0.5;
	}

	.charm-option.disabled image {
		filter: grayscale(50%);
	}

	.charm-badge-icon {
		position: absolute;
		top: 2rpx;
		right: 2rpx;
		font-size: 24rpx;
	}

	.charm-star {
		position: absolute;
		bottom: 2rpx;
		right: 2rpx;
		font-size: 20rpx;
		color: #FFD700;
		font-weight: bold;
		text-shadow: 1rpx 1rpx 2rpx #000;
	}

	.charm-option image {
		width: 100%;
		height: 100%;
	}

	.operation-popup {
		width: 80%;
		max-height: 70vh;
		overflow-y: auto;
	}

	.operation-section {
		margin-bottom: 20rpx;
	}

	.section-title {
		font-size: 28rpx;
		color: #666;
		margin-bottom: 10rpx;
		font-weight: bold;
	}

	.operation-pandas {
		display: flex;
		gap: 15rpx;
		flex-wrap: wrap;
	}

	.operation-panda {
		width: 80rpx;
		height: 80rpx;
		position: relative;
		border-radius: 8rpx;
		overflow: visible;
	}

	.operation-panda image {
		width: 100%;
		height: 100%;
	}

	.panda-star {
		position: absolute;
		bottom: -5rpx;
		right: -5rpx;
		font-size: 20rpx;
		color: #FFD700;
		font-weight: bold;
		text-shadow: 1rpx 1rpx 2rpx #000;
	}

	.no-panda {
		font-size: 24rpx;
		color: #999;
	}

	.operation-charms {
		display: flex;
		gap: 15rpx;
	}

	.operation-charm {
		width: 70rpx;
		height: 70rpx;
	}

	.operation-charm image {
		width: 100%;
		height: 100%;
	}

	/* 暗色模式样式 */
	.main.dark-mode .round-info {
		color: #fff;
	}

	.main.dark-mode .option-item {
		color: #999;
	}

	.main.dark-mode .status-row {
		color: #666;
	}

	.main.dark-mode .status-current {
		background: #1a3a5c;
		color: #409EFF;
	}

	.panda-controls .u-button.reset-btn {
		background: transparent !important;
		border: 1px solid #FF4444 !important;
		color: #FF4444 !important;
	}

	.panda-controls .u-button.help-btn {
		background: transparent !important;
		border:1rpx solid #66b3ff !important;
		color: #66b3ff !important;
		margin-right: 10rpx;
	}
	.main.dark-mode .panda-controls .u-button.help-btn {
		background: #66b3ff !important;
		color: #fff !important;
		margin-right: 10rpx;
	}
	.main.dark-mode .panda-controls .u-button.reset-btn {
		background: #FF4444 !important;
		color: #fff !important;
		margin-right: 10rpx;
	}
	.main.dark-mode .status-text {
		color: #999;
	}

	.main.dark-mode .status-log {
		color: #999;
	}

	.main.dark-mode .status-log.log-error {
		color: #ff6b6b;
	}

	.main.dark-mode .status-log.log-charm {
		color: #ffb84d;
	}

	.main.dark-mode .status-log.log-combine {
		color: #66b3ff;
	}

	.main.dark-mode .status-log.log-sell {
		color: #b37feb;
	}

	.main.dark-mode .board-title,
	.main.dark-mode .bench-title {
		color: #999;
	}

	.main.dark-mode .bench-slot {
		background: #2a2a2a;
	}
	.main.dark-mode .bench-card {
		background: #1a1a1a;
	}

	.main.dark-mode .bench-area {
		background-color: #1a1a1a;
		box-shadow: 0 2px 6px rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .board-area {
		background-color: #1a1a1a;
		box-shadow: 0 2px 6px rgba(0, 0, 0, 0.5);
	}
	
	.main.dark-mode .backpack-area {
		background: #1a1a1a;
		box-shadow: 0 2px 6px rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .board-card {
		background: #1a1a1a;
	}

	.main.dark-mode .board-slot.cell-white {
		background: #3a3a3a;
	}

	.main.dark-mode .board-slot.cell-black {
		background: #2a2a2a;
	}

	.main.dark-mode .charm-display {
		color: #999;
	}



	.main.dark-mode .backpack-title {
		color: #999;
	}

	.main.dark-mode .backpack-charm.empty {
		background: #2a2a2a;
		border-color: #444;
	}

	.main.dark-mode .section-title {
		color: #999;
	}

	.main.dark-mode .panda-status {
		background: #1a1a1a;
		color: #666;
		box-shadow: 0 2px 6px rgba(0, 0, 0, 0.5);
	}

	.main.dark-mode .filter-dot {
		border-color: #999;
	}

	.main.dark-mode .filter-dot.active {
		border-color: #333;
	}

	.main.dark-mode .panda-popup {
		background: #1a1a1a;
	}

	.main.dark-mode .reset-content {
		color: #999;
	}

	.main.dark-mode .popup-title {
		color: #fff;
	}

	.main.dark-mode .source-card {
		color: #409EFF;
	}

	.main.dark-mode .source-drop {
		color: #67C23A;
	}

	.main.dark-mode .summary-header {
		border-bottom-color: #444;
	}

	.main.dark-mode .summary-header text {
		color: #fff;
	}

	.main.dark-mode .summary-row {
		border-bottom-color: #333;
	}

	.main.dark-mode .summary-row text {
		color: #fff;
	}

	.main.dark-mode .summary-total {
		background: #333;
	}

	.main.dark-mode .summary-total text {
		color: #fff;
	}

	.main.dark-mode .panda-name {
		color: #fff;
	}

	.main.dark-mode .popup-name {
		color: #fff;
	}

	.main.dark-mode .popup-dialog {
		color: #999;
	}

	.main.dark-mode .popup-desc {
		color: #666;
	}

	.main.dark-mode .charm-option {
		border-color: #333;
	}

	.main.dark-mode .menu-close {
		color: #999;
	}

	.main.dark-mode>>>.u-button--primary {
		background: #FF4444 !important;
		border-color: #FF4444 !important;
	}

	.u-button--default {
		border: 1px solid #dcdfe6 !important;
	}

	.u-button--warning {
		border: 1px solid #ff9800 !important;
	}

	.main.dark-mode>>>.u-button--default {
		background: #3a3a3a !important;
		border-color: #555 !important;
		color: #fff !important;
	}

	.main.dark-mode>>>.u-button--warning {
		background: #ff9800 !important;
		border-color: #ff9800 !important;
		color: #fff !important;
	}
</style>