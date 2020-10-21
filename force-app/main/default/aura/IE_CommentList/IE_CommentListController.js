// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
	doInit: function(cmp, evt, helper) {
		// 検索に必要な条件を画面から取得
		var recordId = cmp.get('v.recordId');
		var selectedSort = cmp.get('v.selectedSort');
		var showCommentCount = 0;
		helper.getCommentList(cmp, recordId, selectedSort, showCommentCount);
	},
	changeSort: function(cmp, evt, helper) {
		// 検索に必要な条件を画面から取得
		var recordId = cmp.get('v.recordId');
		var selectedSort = cmp.get('v.selectedSort');
		var showCommentCount = 0;
		helper.getCommentList(cmp, recordId, selectedSort, showCommentCount);
	},
	// コメントをさらに表示
	showMoreComment: function(cmp, evt, helper) {
		// ボタンの非活性化フラグ
		cmp.set('v.pageButtonDisabled', true);
		var recordId = cmp.get('v.recordId');
		var selectedSort = cmp.get('v.selectedSort');
		var showCommentCount = cmp.get('v.showCommentCount');
		// コメント一覧取得
		helper.getCommentList(cmp, recordId, selectedSort, showCommentCount);
	}
});
