//  Copyright (c) 2023, salesforce.com, inc.
//  All rights reserved.
//  SPDX-License-Identifier: BSD-3-Clause
//  For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
  closeModel: function(cmp, evt, helper) {
    cmp.set('v.isShowIdeaModal', false);
    //初期化
    cmp.set('v.ideaTitleModal', '');
    cmp.set('v.categoryValue', '');
    cmp.set('v.ideaBodyModal', '');
    cmp.set('v.ideaBodyModal', '');
    //キャンセルの時、モダルidを初期化する
    cmp.set('v.isAnonymous', false);
  },
  //新規作成
  submitDetails: function(cmp, evt, helper) {
    var isPost = 'true';
    //エラーチェック後、問題なければsubmitを行う
    helper.requiredErrorCheck(cmp, isPost);
  },
  //ドラフト作成
  submitDraft: function(cmp, evt, helper) {
    var isPost = 'false';
    //エラーチェック後、問題なければsubmitを行う
    helper.requiredErrorCheck(cmp, isPost);
  }
});
