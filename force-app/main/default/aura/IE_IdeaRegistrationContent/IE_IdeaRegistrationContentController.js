//  Copyright (c) 2023, salesforce.com, inc.
//  All rights reserved.
//  SPDX-License-Identifier: BSD-3-Clause
//  For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
({
  doInit: function (cmp, evt, helper) {
    var categoryListModal = cmp.get('v.categoryListModal');
    var userId = $A.get('$SObjectType.CurrentUser.Id');

    //Check Login
    if (userId && String(userId).trim() != '') {
      cmp.set('v.isLoginUser', userId);
    }

    if (categoryListModal && Object.keys(categoryListModal).length === 0 || categoryListModal == '{}') {
      // 画面に必要な情報取得
      helper.getIdeaPageInfo(cmp);
    }
  },
  handleChange: function(cmp, event) {
    var selectedOptionValue = event.getParam('value');
    var arrayToString = selectedOptionValue.join(';');

    cmp.set('v.categoryValue', selectedOptionValue);
    cmp.set('v.categoryValueStr', arrayToString);
  },
  handleUploadFinished: function(cmp, event) {
    var uploadedFiles = event.getParam("files");
    uploadedFiles.forEach(file => {
        console.log(file.name + ' ' + file.documentId + ' ' + file.ContentVersionId);
    });
  },
	handleAnonymousCommentStateClick: function (cmp, event, helper) {
		var buttonstate = cmp.get('v.anonymousCommentState');
		cmp.set('v.anonymousCommentState', !buttonstate);
	}

})
