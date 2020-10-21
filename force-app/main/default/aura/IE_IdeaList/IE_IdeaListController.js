// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	doInit: function(cmp, evt, helper) {
		helper.addSpinner(cmp);

		const param = helper.getUrlQuery(cmp);

		if (param) {
			if (param.c__category && String(param.c__category).trim() != '') {
				cmp.set('v.selectedCategory', param.c__category);
			}
			if (param.c__status && String(param.c__status).trim() != '') {
				cmp.set('v.selectedStatus', param.c__status);
			}
			if (param.c__sortVal && String(param.c__sortVal).trim() != '') {
				cmp.set('v.selectedSort', param.c__sortVal);
			}
			if (param.c__showIdeaLimit && String(param.c__showIdeaLimit).trim() != '') {
				cmp.set('v.showIdeaLimit', param.c__showIdeaLimit);
			}
			if (param.c__offset && String(param.c__offset).trim() != '') {
				cmp.set('v.offset', param.c__offset);
			}
		} else {
			if (cmp.get('v.selectedSort')) {
				cmp.set('v.selectedSort', cmp.get('v.selectedSort'));
			}
		}

		// アイデア一覧取得
		helper.getIdeaList(cmp);
	},
	// カテゴリ選択イベント
	doSelectedCategory: function(cmp, evt, helper) {
		const cat = evt.getParam('value') || evt.getParam('name');

		if (cat) {
			helper.addSpinner(cmp);

			// 検索条件を画面に設定 初期化
			cmp.set('v.selectedStatus', cmp.get('v.conditionInitialVal'));
			cmp.set('v.offset', '0');

			// アイデア一覧取得
			clearTimeout(window.doSelectedCategoryTimer);
			window.doSelectedCategoryTimer = setTimeout(() => {
				helper.getIdeaList(cmp);
			}, 200);
		}
	},
	// 状況選択イベント
	doSelectedStatus: function(cmp, evt, helper) {
		helper.addSpinner(cmp);

		cmp.set('v.offset', 0);
		// 検索条件を画面に設定
		cmp.set('v.selectedStatus', evt.getParam('value'));
		// アイデア一覧取得
		helper.getIdeaList(cmp);
	},
	// ソート選択イベント
	doSelectedSort: function(cmp, evt, helper) {
		helper.addSpinner(cmp);

		cmp.set('v.offset', 0);
		// 検索条件を画面に設定
		cmp.set('v.selectedSort', evt.getParam('value'));
		// アイデア一覧取得
		helper.getIdeaList(cmp);
	},
	// ページング処理　前へ
	doPrev: function(cmp, evt, helper) {
		helper.addSpinner(cmp);

		// ボタンの非活性化フラグ
		cmp.set('v.pageButtonDisabled', true);

		// 検索条件を画面に設定
		var showIdeaLimit = cmp.get('v.showIdeaLimit');
		var offset = cmp.get('v.offset');
		if (!offset <= 0) {
			offset -= showIdeaLimit;
		}
		cmp.set('v.offset', offset);

		// アイデア一覧取得
		helper.getIdeaList(cmp);
	},
	// ページング処理　次へ
	doNext: function(cmp, evt, helper) {
		helper.addSpinner(cmp);

		// ボタンの非活性化フラグ
		cmp.set('v.pageButtonDisabled', true);

		// 検索条件を画面に設定
		var offset = cmp.get('v.offset');
		var showIdeaLimit = cmp.get('v.showIdeaLimit');
		offset += showIdeaLimit;
		cmp.set('v.offset', offset);

		// アイデア一覧取得
		helper.getIdeaList(cmp);
	}
});
