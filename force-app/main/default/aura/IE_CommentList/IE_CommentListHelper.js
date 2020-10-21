// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	// コメントを取得する
	getCommentList: function(cmp, recordId, selectedSort, showCommentCount) {
		// サーバ処理呼出
		var action = cmp.get('c.getCommentListInfo');
		action.setParams({
			recordId: recordId,
			showCommentCount: showCommentCount,
			selectedSort: selectedSort
		});
		// set a call back
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === 'SUCCESS') {
				var ideaCommentListInfo = response.getReturnValue();

				//コメントリスト
				var IdeaCommentBeanList = ideaCommentListInfo.IdeaCommentBeanList;
				//コメント件数（カスタム表示ラベルで固定）
				var showCommentCount = ideaCommentListInfo.showCommentCount;
				//総コメント件数
				var grandCommentCount = ideaCommentListInfo.grandCommentCount;

				const commentList = IdeaCommentBeanList.filter((item) => {
					return item.isPickup;
				});

				// 戻り値を画面に設定
				cmp.set('v.pickupList', commentList);
				cmp.set('v.commentList', IdeaCommentBeanList);
				cmp.set('v.showCommentCount', showCommentCount);
				cmp.set('v.commentNumber', grandCommentCount);
				//コメントが存在するかをチェックする。
				if (grandCommentCount == 0) {
					//コメントがない場合、コメントリストエリア非表示
					cmp.set('v.isCommentExist', false);
				} else {
					//コメントがある場合、コメントリストエリア表示
					cmp.set('v.isCommentExist', true);
				}
				var isShowMoreDisp = true;
				//①コメントリスト件数 < コメント件数（カスタム表示ラベルで固定）
				//②コメントリスト件数 = コメント総件数
				//の場合、「さらに表示」を表示しない
				if (IdeaCommentBeanList.length < showCommentCount || IdeaCommentBeanList.length == grandCommentCount) {
					isShowMoreDisp = false;
				}
				// ボタンの非活性化フラグ
				cmp.set('v.showMoreButtonDisabled', isShowMoreDisp);
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
			message: $A.get('$Label.c.IE_Idea_InputRequired'),
			messageTemplate: messageTemplate,
			messageTemplateData: messageList,
			type: 'error'
		});
		toastEvent.fire();
	}
});
