// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	getUrlQuery: function(cmp) {
		const currentPageReference = cmp.get('v.pageReference');
		let param;

		if (!currentPageReference) {
			const sPageURL = decodeURIComponent(window.location.search.substring(1));

			if (sPageURL && sPageURL.length > 0) {
				param = {};
				const sURLVariables = sPageURL.split('&');

				sURLVariables.filter((d) => {
					let querySet = d.split('=');
					param[querySet[0]] = querySet[1];
				});
			}
		}

		return param;
	},
	// アイデア一覧取得
	getIdeaList: function(cmp) {
		// 検索条件取得
		const category = cmp.get('v.selectedCategory');
		const status = cmp.get('v.selectedStatus');
		const sortVal = cmp.get('v.selectedSort');
		const showIdeaLimit = cmp.get('v.showIdeaLimit');
		const offset = cmp.get('v.offset');

		// サーバ処理呼出
		const action = cmp.get('c.getIdeaList');
		try {
			//set Url State
			const isCommunity = cmp.get('v.isCommunity');
			const pageName = cmp.get('v.pageName');
			const navService = cmp.find('navService');
			const state = {
				c__category: category,
				c__status: status,
				c__sortVal: sortVal,
				c__showIdeaLimit: showIdeaLimit,
				c__offset: offset
			};

			if (pageName) {
				const attribute = isCommunity ? { pageName: pageName } : { apiName: pageName };
				const pageReference = {
					type: isCommunity ? 'comm__namedPage' : 'standard__navItemPage',
					attributes: attribute,
					state: state
				};

				cmp.set('v.pageReference', pageReference);
				navService.generateUrl(pageReference).then(
					$A.getCallback((url) => {
						let _url = url;

						if (!_url) {
							let q = [];
							for (let k in state) {
								q.push(`${k}=${state[k]}`);
							}
							_url = `?${q.join('&')}`;
						}

						try {
							history.replaceState(state, 'List Page', _url);
						} catch (e) {
							console.error('history.replaceState Error', e);
						}
					})
				);
			}
		} catch (e) {
			console.error('History set error', e);
		}

		action.setParams({
			category: category,
			status: status,
			sortVal: sortVal,
			showIdeaLimit: showIdeaLimit,
			offset: offset
		});

		// set a call back
		action.setCallback(this, function(response) {
			var state = response.getState();

			if (state === 'SUCCESS') {
				var ideaListInfo = response.getReturnValue();

				// 戻り値を画面に設定
				cmp.set('v.ideaList', ideaListInfo.IdeaCellList);
				cmp.set('v.showIdeaLimit', ideaListInfo.showIdeaLimit);
				cmp.set('v.offset', ideaListInfo.offset);

				//offsetBeginの初期値を設定
				var offsetBegin = ideaListInfo.offset + 1;

				//リストのサイズが0の場合、offsetBeginを0として設定
				if (ideaListInfo.IdeaCellList.length == 0) {
					offsetBegin = 0;
				}

				cmp.set('v.offsetBegin', offsetBegin);
				cmp.set('v.listTotalCount', ideaListInfo.ideaCount);
				var offsetEnd = ideaListInfo.offset + ideaListInfo.showIdeaLimit;

				// 最終ページの場合、オフセットに総合計を設定
				if (ideaListInfo.ideaCount < ideaListInfo.offset + ideaListInfo.showIdeaLimit) {
					offsetEnd = ideaListInfo.ideaCount;
				}
				cmp.set('v.offsetEnd', offsetEnd);

				// ボタンの非活性化フラグ
				cmp.set('v.pageButtonDisabled', false);

				//init終了後spinnerを解除する
				var spinner = cmp.find('ideaListMainDiv');
				$A.util.removeClass(spinner, 'slds-hide');
				var spinner = cmp.find('mySpinner');
				$A.util.addClass(spinner, 'slds-hide');
			} else if (state === 'ERROR') {
				var errors = response.getError();
				this.showError($A.get('$Label.c.IE_ErrMsg_SystemErr'), errors);
			}
		});
		$A.enqueueAction(action);
	},
	showError: function(messageTemplate, errors) {
		var message = 'Unknown error'; // Default error message
		// Retrieve the error message sent by the server
		if (errors && Array.isArray(errors) && errors.length > 0) {
			message = errors[0].message;
		}
		var messageList = [];
		messageList.push(message);
		var toastEvent = $A.get('e.force:showToast');
		toastEvent.setParams({
			message: 'Idea List Helper: ' + $A.get('$Label.c.IE_Idea_InputRequired'),
			messageTemplate: messageTemplate,
			messageTemplateData: messageList,
			type: 'error'
		});
		toastEvent.fire();
	},
	addSpinner: function(cmp) {
		$A.util.addClass(cmp.find('ideaListMainDiv'), 'slds-hide');
		$A.util.removeClass(cmp.find('mySpinner'), 'slds-hide');
	}
});
