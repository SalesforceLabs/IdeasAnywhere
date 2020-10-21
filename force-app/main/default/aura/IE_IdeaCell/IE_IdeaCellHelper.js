// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	pressLikeDislike: function(cmp, recordId, isLike, point) {
		// サーバ処理呼出
		var action = cmp.get('c.pressLikeDislike');
		action.setParams({
			recordId: recordId,
			isLike: isLike,
			point: point
		});
		// set a call back
		action.setCallback(this, function(response) {
			var state = response.getState();

			if (state === 'SUCCESS') {
				var resultIdeaRow = response.getReturnValue();
				cmp.set('v.points', resultIdeaRow.points);
				cmp.set('v.isPositive', resultIdeaRow.isPositive);
			} else if (state === 'ERROR') {
				var errors = response.getError();
				this.showError($A.get('$Label.c.IE_ErrMsg_SystemErr'), errors);
			}
		});
		$A.enqueueAction(action);
	},
	deleteIdea: function(cmp, recordId) {
		// サーバ処理呼出
		var action = cmp.get('c.deleteDraftIdea');
		action.setParams({
			recordId: recordId
		});
		// set a call back
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === 'SUCCESS') {
				// 正常終了メッセージ表示
				var toastEvent = $A.get('e.force:showToast');
				toastEvent.setParams({
					title: 'Success!',
					message: $A.get('$Label.c.IE_Successful_Completion'),
					type: 'success'
				});
				toastEvent.fire();

				//削除後一覧再描画
				// アイデア一覧画面表示Event呼出（遷移元の一覧にそのまま戻るため、パラメーター設定なし）
				var compEvent = cmp.getEvent('ideaListShowEvt');
				compEvent.fire();
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
