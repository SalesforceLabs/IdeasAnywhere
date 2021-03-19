// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

({
  submitIdea: function(cmp, ideaTitleModal, ideaBodyModal, categoryModal, isPost, recordId, point) {
    // サーバ処理呼出
    const action = cmp.get('c.submitIdea');

    action.setParams({
      ideaTitleModal: ideaTitleModal,
      ideaBodyModal: ideaBodyModal,
      categoryModal: categoryModal,
      isPost: isPost,
      recordId: recordId,
      point: point
    });

    // set a call back
    action.setCallback(this, function(response) {
      const state = response.getState();

      if (state === 'SUCCESS') {
        const resulteVal = response.getReturnValue();

        //正常終了メッセージを出力
        const toastEvent = $A.get('e.force:showToast');
        toastEvent.setParams({
          title: 'Success!',
          message: $A.get('$Label.c.IE_Successful_Completion_Save'),
          type: 'success'
        });
        toastEvent.fire();

        //初期化
        this.Initialization(cmp, resulteVal);
      } else if (state === 'ERROR') {
        const errors = response.getError();
        console.log('errors : ' + errors);
        this.showError($A.get('$Label.c.IE_ErrMsg_SystemErr'), errors);
      }
    });

    $A.enqueueAction(action);
  },
  //submit後、リストページへ遷移
  Initialization: function(cmp, recordId) {
    const isCommunity = cmp.get('v.isCommunity');
    const pageName = cmp.get('v.pageName');
    const navService = cmp.find('navService');
    const state = {
      c__category: $A.get('$Label.c.IE_Condition_MyIdea'),
      c__status: $A.get('$Label.c.IE_Condition_Initial_Value'),
      c__sortVal: $A.get('$Label.c.IE_Sort_Value_Latest')
    };

    if (pageName) {
      const attribute = isCommunity ? { pageName: pageName } : { apiName: pageName };
      const pageReference = {
        type: isCommunity ? 'comm__namedPage' : 'standard__navItemPage',
        attributes: attribute,
        state: state
      };
      navService.navigate(pageReference);

      // アイデア一覧表示処理呼出
      const compEvent = cmp.getEvent('ideaListShowEvt');
      compEvent.fire();
    }
  },
  showError: function(messageTemplate, errors) {
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
  },
  requiredErrorCheck: function(cmp, isPost) {
    let recordId = cmp.get('v.recordIdModal');
    let ideaTitleModal = cmp.get('v.ideaTitleModal');
    let ideaBodyModal = cmp.get('v.ideaBodyModal');
    let categoryModal = cmp.get('v.categoryValue');
    let point = cmp.get('v.positiveVotePoint');
    let errorItemList = [];
    let errorItem = '';

    //エラーメッセージの文字列を設定
    if (ideaTitleModal == '' || ideaTitleModal == null) {
      errorItem = errorItem + $A.get('$Label.c.IE_Fixed_Value_Title');
    }
    if (ideaBodyModal == '' || ideaBodyModal == null) {
      errorItem = errorItem + $A.get('$Label.c.IE_Fixed_Value_Content');
    }
    if (categoryModal == '' || categoryModal == null) {
      errorItem = errorItem + $A.get('$Label.c.IE_Fixed_Value_Category');
    }

    //エラーメッセージの最後の文字を取得し、','かを判定する
    let lastCharacter = errorItem.substr(errorItem.length - 1);

    if (lastCharacter == ',') {
      errorItem = errorItem.substring(0, errorItem.length - 1);
    }

    //エラーがない場合、正常submitを行う
    if (errorItem == '' || errorItem == null) {
      this.submitIdea(cmp, ideaTitleModal, ideaBodyModal, categoryModal, isPost, recordId, point);
      //エラーがある場合、エラーメッセージを表示する
    } else {
      errorItemList = [{ message: errorItem }];
      this.showError($A.get('$Label.c.IE_ErrMsg_Required'), errorItemList);
    }
  }
});
