// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	getIdea: function(cmp, recordId) {
		const isLoginUser = cmp.get('v.isLoginUser');

		// サーバ処理呼出
		const action = cmp.get('c.getIdeaDetail');
		action.setParams({
			recordId: recordId
		});
		// set a call back
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === 'SUCCESS') {
				var resultIdeaRow = response.getReturnValue();
				// 画面にアイデア一覧を設定
				cmp.set('v.ideaTitle', resultIdeaRow.title);
				cmp.set('v.ideaBody', resultIdeaRow.ideaBody);
				cmp.set('v.category', resultIdeaRow.categories);

				const categoryList = [];
				if (resultIdeaRow.categoriesLabel && resultIdeaRow.categoriesLabel.length > 0) {
					resultIdeaRow.categoriesLabel.split(';').filter((d) => {
						categoryList.push(d.replace(/^\d+/, ''));
					});
				}
				cmp.set('v.categoryLabel', categoryList);

				cmp.set('v.loginUserAvatarUrl', resultIdeaRow.photoUrl);
				cmp.set('v.isPost', resultIdeaRow.isPost);
				cmp.set('v.isPositive', resultIdeaRow.isPositive);
				cmp.set('v.isClosed', resultIdeaRow.isClosed);

				if (isLoginUser && !resultIdeaRow.isClosed) {
					$A.util.removeClass(cmp.find('detailVote'), 'slds-hide');
					$A.util.removeClass(cmp.find('detailComment'), 'slds-hide');
				}

				//sideInfo
				cmp.set('v.postUserAvatarName', resultIdeaRow.postUserName);
				cmp.set('v.postUserAvatarUrl', resultIdeaRow.postUserPhotoUrl);
				cmp.set('v.points', resultIdeaRow.points);
				cmp.set('v.createdDate', resultIdeaRow.createdDate);
				cmp.set('v.statusValue', resultIdeaRow.status);
			} else if (state === 'ERROR') {
				var errors = response.getError();
				this.showError($A.get('$Label.c.IE_ErrMsg_SystemErr'), errors);
			}
		});
		$A.enqueueAction(action);
	},
	pressLikeDislikeHelper: function(cmp, recordId, isLike, point) {
		// サーバ処理呼出
		var action = cmp.get('c.pressLikeDislike');
		action.setParams({
			recordId: recordId,
			isLike: isLike,
			point: point // 編集画面から取得したポイント
		});

		// set a call back
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === 'SUCCESS') {
				//再描画
				this.getIdea(cmp, recordId);
			} else if (state === 'ERROR') {
				var errors = response.getError();
				this.showError($A.get('$Label.c.IE_ErrMsg_SystemErr'), errors);
			}
		});
		$A.enqueueAction(action);
	},
	addComment: function(cmp, recordId, ideaComment) {
		// サーバ処理呼出
		var action = cmp.get('c.submitComment');
		action.setParams({
			recordId: recordId,
			ideaComment: ideaComment
		});
		// set a call back
		action.setCallback(this, function(response) {
			var state = response.getState();
			if (state === 'SUCCESS') {
				//コメント欄を空欄として設定する
				cmp.set('v.comment', '');
				//保存後、ソート順を新しい順として設定
				cmp.set('v.defaultCommentSort', $A.get('$Label.c.IE_Sort_Value_New_Order'));

				//この処理は「コメント追加」時のため、対応するための処理です。
				var isCommentAdded = cmp.get('v.isCommentAdded');
				if (isCommentAdded) {
					cmp.set('v.isCommentAdded', false);
				} else {
					cmp.set('v.isCommentAdded', true);
				}
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
			message: '必須欄',
			messageTemplate: messageTemplate,
			messageTemplateData: messageList,
			type: 'error'
		});
		toastEvent.fire();
	}
});
