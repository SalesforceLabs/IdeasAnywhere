// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	//bodyの長さを取得
	doInit: function(cmp, evt, helper) {
		//ideaBodyの長さの調整
		let ideaBody = cmp.get('v.ideaBody');

		const categoryValue = cmp.get('v.categoryValue');
		const categoryList = [];

		if (categoryValue && categoryValue.length > 0) {
			categoryValue.split(';').filter((d) => {
				categoryList.push(d.replace(/^\d+/, ''));
			});
		}

		cmp.set('v.categoryList', categoryList);
		cmp.set('v.ideaBodyLengthCheck', true);
		cmp.set('v.ideaBodyShow', ideaBody);
	},
	deleteIdea: function(cmp, evt, helper) {
		// 検索に必要な条件を画面から取得
		var recordId = cmp.get('v.recordId');
		helper.deleteIdea(cmp, recordId);
	},
	callShowIdeaDetail: function(cmp, evt, helper) {
		// アイデア詳細画面表示Event呼出
		// get the selected record from list
		const recordId = cmp.get('v.recordId');
		const navService = cmp.find('navService');
		const pageReference = {
			type: 'standard__recordPage',
			attributes: {
				recordId: recordId,
				objectApiName: 'IdeaPost__c',
				actionName: 'view'
			}
		};
		navService.navigate(pageReference);
	},
	pressLikeDislikeButton: function(cmp, evt, helper) {
		// ボタンの非活性化
		var btnClicked = evt.getSource();
		btnClicked.set('v.disabled', true);
		var isLike = evt.getSource().get('v.value');
		var point = isLike === 'true' ? cmp.get('v.positiveVotePoint') : cmp.get('v.negativeVotePoint');
		var recordId = cmp.get('v.recordId');

		helper.pressLikeDislike(cmp, recordId, isLike, point);
	},
	openModel: function(cmp, evt, helper) {
		// アイデア詳細画面表示Event呼出
		var recordId = cmp.get('v.recordId');
		var title = cmp.get('v.title');
		var ideaBody = cmp.get('v.ideaBody');
		var categoryValue = cmp.get('v.categoryValue');
		// call the event
		var compEvent = cmp.getEvent('modalShowEvt');
		compEvent.setParams({
			recordIdModal: recordId,
			ideaTitleModal: title,
			ideaBodyModal: ideaBody,
			categoryValue: categoryValue
		});
		// fire the event
		compEvent.fire();
	}
});
