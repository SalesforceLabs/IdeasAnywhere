// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	getIdeaPageInfo: function(cmp) {
		// サーバ処理呼出
		var action = cmp.get('c.getCommunityInfo');

		// set a call back
		action.setCallback(this, function(response) {
			const state = response.getState();

			if (state === 'SUCCESS') {
				var resulteVal = response.getReturnValue();
				// コミュニティ名
				cmp.set('v.communityName', resulteVal.communityName);
				// カテゴリリスト
				cmp.set('v.categoryList', resulteVal.categoryList);
				// モーダル上カテゴリリスト
				cmp.set('v.categoryListModal', resulteVal.categoryListModal);
				// 状態リスト
				cmp.set('v.statusList', resulteVal.statusList);
				// Like Point
				cmp.set('v.positiveVotePoint', resulteVal.likePoint);
				// Dislike Point
				cmp.set('v.negativeVotePoint', resulteVal.dislikePoint);
				// Show　Negative　Vote
				cmp.set('v.isShowNegativeVote', resulteVal.showNegativeVote);
				// List Page Name
				cmp.set('v.pageName', resulteVal.pageName);
			} else if (state === 'ERROR') {
				var errors = response.getError();
				this.showError($A.get('$Label.c.IE_ErrMsg_SystemErr'), errors);
			}

			const recordId = cmp.get('v.recordId');

			//True id Detail Action, False is List Action
			if (recordId && String(recordId).trim() != '') {
				//sortListCommentListのデフォルト値を設定する（固定値）
				const sortListCommentList = [
					{ label: $A.get('$Label.c.IE_Sort_Value_New_Order'), value: $A.get('$Label.c.IE_Sort_Value_New_Order') },
					{ label: $A.get('$Label.c.IE_Sort_Value_Oldest_First'), value: $A.get('$Label.c.IE_Sort_Value_Oldest_First') }
				];

				cmp.set('v.sortListCommentList', sortListCommentList);

				// call the event
				const compEvent = cmp.getEvent('ideaDetailShowEvt');
				// set the Selected sObject Record to the event attribute.
				compEvent.setParams({ recordIdDetail: recordId });
				// fire the event
				compEvent.fire();
			} else {
				//sortListのデフォルト値を設定する（固定値）
				const sortList = [
					{ label: $A.get('$Label.c.IE_Sort_Value_Trend'), value: $A.get('$Label.c.IE_Sort_Value_Trend') },
					{ label: $A.get('$Label.c.IE_Sort_Value_Latest'), value: $A.get('$Label.c.IE_Sort_Value_Latest') },
					{ label: $A.get('$Label.c.IE_Sort_Value_Closed'), value: $A.get('$Label.c.IE_Sort_Value_Closed') }
				];
				cmp.set('v.sortList', sortList);

				//メインラベルの設定
				cmp.set('v.mainLabel', $A.get('$Label.c.IE_Idea_List'));
				cmp.set('v.isShowIdeaList', true);
				cmp.set('v.doneInit', true);
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
