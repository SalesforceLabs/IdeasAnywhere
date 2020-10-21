// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	doInit: function(cmp, evt, helper) {
		// 検索に必要な条件を画面から取得
		const recordId = cmp.get('v.recordId');
		helper.getIdea(cmp, recordId);
	},
	pressLikeDislikeButton: function(cmp, evt, helper) {
		// ボタンの非活性化
		var btnClicked = evt.getSource();
		btnClicked.set('v.disabled', true);
		var isLike = evt.getSource().get('v.value');
		var point = isLike === 'true' ? cmp.get('v.positiveVotePoint') || 10 : cmp.get('v.negativeVotePoint') || -10;
		var recordId = cmp.get('v.recordId');

		helper.pressLikeDislikeHelper(cmp, recordId, isLike, point);
	},
	addComment: function(cmp, evt, helper) {
		var recordId = cmp.get('v.recordId');
		var ideaComment = cmp.get('v.comment');
		var errorItemList = [];

		//エラーメッセージの文字列を設定
		if (ideaComment == '' || ideaComment == null) {
			errorItemList = [{ message: $A.get('$Label.c.IE_Fixed_Value_Comment') }];
			helper.showError($A.get('$Label.c.IE_ErrMsg_Required'), errorItemList);
		} else {
			helper.addComment(cmp, recordId, ideaComment);
		}
	},
	showIdeaList: function(cmp, evt, helper) {
		const isCommunity = cmp.get('v.isCommunity');
		const pageName = cmp.get('v.pageName');
		const navService = cmp.find('navService');
		const device = $A.get('$Browser.formFactor');

		if (isCommunity || device === 'DESKTOP') {
			return history.back();
		} else {
			let attributes;
			let typeName;

			if (isCommunity) {
				typeName = 'comm__namedPage';
				attributes = {
					pageName: pageName
				};
			} else {
				typeName = 'standard__navItemPage';
				attributes = {
					apiName: pageName
				};
			}
			const pageReference = {
				type: typeName,
				attributes: attributes
			};
			navService.navigate(pageReference);
		}
	}
});
