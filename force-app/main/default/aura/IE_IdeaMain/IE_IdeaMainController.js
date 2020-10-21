// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	doInit: function(cmp, evt, helper) {
		const userId = $A.get('$SObjectType.CurrentUser.Id');

		//Check Login
		if (userId && String(userId).trim() != '') {
			cmp.set('v.isLoginUser', true);
		}

		// 画面に必要な情報取得
		helper.getIdeaPageInfo(cmp);
	},
	// アイデア詳細表示
	ideaDetailShow: function(cmp, evt, helper) {
		// イベントからパラメーター取得（recordId）
		var recordId = evt.getParam('recordIdDetail');
		// アイデアID画面に設定
		cmp.set('v.recordIdDetail', recordId);
		// 各画面表示制御
		cmp.set('v.isShowIdeaList', false);
		//ideaDetail画面表示チェックフラグ
		cmp.set('v.isShowIdeaDetail', true);
		cmp.set('v.isShowIdeaModal', false);
		//メインラベルの設定
		cmp.set('v.mainLabel', $A.get('$Label.c.IE_Idea_Detail'));
	},
	// アイデア登録表示
	modalShow: function(cmp, evt, helper) {
		//ドラフトの場合（レコードがある場合）
		var recordId = evt.getParam('recordIdModal');
		if (recordId != null && recordId != undefined) {
			cmp.set('v.recordIdModal', recordId);
			cmp.set('v.ideaTitleModal', evt.getParam('ideaTitleModal'));
			cmp.set('v.ideaBodyModal', evt.getParam('ideaBodyModal'));
			cmp.set('v.categoryValue', evt.getParam('categoryValue').split(';'));
		}
		//モーダル画面表示
		cmp.set('v.isShowIdeaModal', true);
	},
	// アイデア一覧表示
	ideaListShow: function(cmp, evt, helper) {
		cmp.set('v.doneInit', false);
		cmp.set('v.isShowIdeaModal', false);
		cmp.set('v.isShowIdeaList', false);
		const IdeaList = cmp.find('IdeaList');
		const spinner = IdeaList ? IdeaList.find('mySpinner') : null;
		if (spinner) {
			$A.util.removeClass(spinner, 'slds-hide');
		}

		// 画面に必要な情報取得
		helper.getIdeaPageInfo(cmp);
	},
	doneRendering: function(cmp, evt, helper) {
		const doneInit = cmp.get('v.doneInit');
		const isShowIdeaList = cmp.get('v.isShowIdeaList');
		const IdeaList = cmp.find('IdeaList');
		const spinner = IdeaList ? IdeaList.find('mySpinner') : null;

		if (doneInit && isShowIdeaList && spinner && !$A.util.hasClass(spinner, 'slds-hide')) {
			$A.util.addClass(spinner, 'slds-hide');
		}
	}
});
