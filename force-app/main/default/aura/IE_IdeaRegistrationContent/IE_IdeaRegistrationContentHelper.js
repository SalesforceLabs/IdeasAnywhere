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
                // モーダル上カテゴリリスト
                cmp.set('v.categoryListModal', resulteVal.categoryListModal);
                // 匿名投稿を許可
                cmp.set('v.enableAnonymousPost', resulteVal.enableAnonymousPost);
            } else if (state === 'ERROR') {
                var errors = response.getError();
                this.showError($A.get('$Label.c.IE_ErrMsg_SystemErr'), errors);
            }
        });

        $A.enqueueAction(action);
    },
    showError: function (messageTemplate, errors) {
        let message = 'Unknown error'; // Default error message

        // Retrieve the error message sent by the server
        if (errors && Array.isArray(errors) && errors.length > 0) {
        message = errors[0].message;
        }

        let messageList = [];
        messageList.push(message);

        let toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
        message: $A.get('$Label.c.IE_Idea_InputRequired'),
        messageTemplate: messageTemplate,
        messageTemplateData: messageList,
        type: 'error'
        });
        toastEvent.fire();
    }
})
