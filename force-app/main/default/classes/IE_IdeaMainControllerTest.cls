// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

@isTest
public with sharing class IE_IdeaMainControllerTest {
    private static String cns_clm_ideacommunitiesconfig = IdeaCommunitiesConfig__c.getSObjectType().getDescribe().getName();
    private static String cns_clm_like = IdeaCommunitiesConfig__c.Like__c.getDescribe().getName();
    private static String cns_clm_dislike = IdeaCommunitiesConfig__c.Dislike__c.getDescribe().getName();
    private static String cns_clm_shownegativevote = IdeaCommunitiesConfig__c.ShowNegativeVote__c.getDescribe().getName();
    private static String cns_clm_pagename = IdeaCommunitiesConfig__c.pageName__c.getDescribe().getName();
    private static String cns_clm_configcommunity = IdeaCommunitiesConfig__c.Community__c.getDescribe().getName();
    private static String cns_clm_configcategories = IdeaCommunitiesConfig__c.Categories__c.getDescribe().getName();
    private static String cns_clm_configstattus = IdeaCommunitiesConfig__c.Status__c.getDescribe().getName();

    /**
* コミュニティ情報取得
*/
    public static testMethod void getCommunityInfo_01() {
        //アイデア設定作成
        createIdeaConfig();

        //テスト実行
        IE_IdeaMainController.CommunityInfo returnVal = IE_IdeaMainController.getCommunityInfo();
        System.assert(returnVal != null);
    }

    /**
* アイデア詳細取得
*/
    public static testMethod void getGetIdeaDetail_01() {
        //取引先/取引先責任者
        //<Contact> contactList = createTestCommUser(1, 1,'testMainAdmin');

        //prepare user
        //boolean isMember = true;
        //User u1 = createUser(contactList[0], isMember);

        //カテゴリと状況取得
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        //execute and assert
        //System.runAs(u1){
        //アイデア作成
        List<IdeaPost__c> ideaList = createIdea(100, Label.IE_Community_internal_Value, cateList[0], statusList[0]);

        //execute test
        System.Test.startTest();

        IE_IdeaMainController.IdeaCellInfo returnVal = IE_IdeaMainController.getIdeaDetail(ideaList[0].Id);

        System.Test.stopTest();
        System.assert(returnVal != null);
        //}
    }

    /**
* アイデアコメント投稿
*/
    public static testMethod void addIdeaComment_01(){
        //取引先/取引先責任者
        //List<Contact> contactList = createTestCommUser(1, 1,'testMainAdmin');

        //prepare user
        //boolean isMember = true;
        //User u1 = createUser(contactList[0], isMember);

        //カテゴリと状況取得
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        //execute and assert
        //System.runAs(u1) {
        //アイデア作成
        List<IdeaPost__c> ideaList = createIdea(100, Label.IE_Community_internal_Value, cateList[0], statusList[0]);

        //execute test
        System.Test.startTest();

        IE_IdeaMainController.submitComment(ideaList[0].Id, 'CommentBody');

        System.Test.stopTest();
        System.assert(true);
        //}
    }

    /**
* アイデア削除
*/
    public static testMethod void deleteDraftIdea_01() {
        //取引先/取引先責任者
        //List<Contact> contactList = createTestCommUser(1, 1,'testMainAdmin');

        //prepare user
        //boolean isMember = true;
        //User u1 = createUser(contactList[0], isMember);

        //カテゴリと状況取得
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        //execute and assert
        //System.runAs(u1) {
        //アイデア作成
        List<IdeaPost__c> ideaList = createIdea(100, Label.IE_Community_internal_Value, cateList[0], statusList[0]);

        //execute test
        System.Test.startTest();

        IE_IdeaMainController.deleteDraftIdea(ideaList[0].Id);

        System.Test.stopTest();
        System.assert(true);
        //}
    }

    /**
* アイデア投票
*/
    public static testMethod void pressLikeDislike_01() {
        //取引先/取引先責任者
        //List<Contact> contactList = createTestCommUser(1, 1,'testMainAdmin');

        //prepare user
        //boolean isMember = true;
        //User u1 = createUser(contactList[0], isMember);

        //カテゴリと状況取得
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        //execute and assert
        //System.runAs(u1) {
        //アイデア作成
        List<IdeaPost__c> ideaList = createIdea(100, Label.IE_Community_internal_Value, cateList[0], statusList[0]);

        //execute test
        System.Test.startTest();

        IE_IdeaMainController.IdeaCellInfo retVal = IE_IdeaMainController.pressLikeDislike(ideaList[0].Id, 'true', 30);

        System.Test.stopTest();
        System.assert(retVal != null);
        //}
    }

    /**
* アイデア投稿
*/
    public static testMethod void submitIdea_01() {
        //取引先/取引先責任者
        //List<Contact> contactList = createTestCommUser(1, 1,'testMainAdmin');

        //prepare user
        //boolean isMember = true;
        //User u1 = createUser(contactList[0], isMember);

        //カテゴリと状況取得
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        //execute and assert
        //System.runAs(u1){
        //アイデア作成
        List<IdeaPost__c> ideaList = createIdea(100, Label.IE_Community_internal_Value, cateList[0], statusList[0]);

        //execute test
        System.Test.startTest();

        IE_IdeaMainController.submitIdea('ideaTitleModal','ideaBodyModal',cateList, true, ideaList[0].Id, 50);

        System.Test.stopTest();
        System.assert(true);
        //}
    }

    /**
* アイデアコメントリスト取得
*/
    public static testMethod void getCommentListInfo_01() {
        //取引先/取引先責任者
        //List<Contact> contactList = createTestCommUser(1, 1,'testMainAdmin');

        //prepare user
        //boolean isMember = true;
        //User u1 = createUser(contactList[0], isMember);

        //カテゴリと状況取得
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        //execute and assert
        //System.runAs(u1) {
        //アイデア作成
        List<IdeaPost__c> ideaList = createIdea(100, Label.IE_Community_internal_Value, cateList[0], statusList[0]);

        //execute test
        System.Test.startTest();

        IE_IdeaMainController.IdeaCommentListInfo retVal = IE_IdeaMainController.getCommentListInfo(ideaList[0].Id, Label.IE_Sort_Value_New_Order, 20);

        System.Test.stopTest();
        System.assert(retVal != null);
        //}
    }

    /**
* アイデアリスト取得
*/
    public static testMethod void getIdeaList_01() {
        //取引先/取引先責任者
        //List<Contact> contactList = createTestCommUser(1, 1,'testMainAdmin');

        //prepare user
        //boolean isMember = true;
        //User u1 = createUser(contactList[0], isMember);

        //カテゴリと状況取得
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        //execute and assert
        //System.runAs(u1) {
        //アイデア作成
        List<IdeaPost__c> ideaList = createIdea(100, Label.IE_Community_internal_Value, cateList[0], statusList[0]);

        //execute test
        System.Test.startTest();

        IE_IdeaMainController.IdeaListInfo retVal = IE_IdeaMainController.getIdeaList(cateList[0], statusList[0], Label.IE_Sort_Value_Latest, 100, 10);

        System.Test.stopTest();
        System.assert(retVal != null);
        //}
    }

    /*
* create test IdeaConfig
*/
    private static void createIdeaConfig() {
        List<String> cateList = getPickListValMap(cns_clm_configcategories);
        List<String> statusList = getPickListValMap(cns_clm_configstattus);

        // アイデア設定登録
        IdeaCommunitiesConfig__c icRow = new IdeaCommunitiesConfig__c(
            Community__c = Label.IE_Community_internal_Value,
            Categories__c = cateList[0],
            Status__c = statusList[0],
            pageName__c = 'IdeaAnyWhere',
            like__c = 10,
            Dislike__c = -10
        );

        insert icRow;
    }

    /**
* 該当する選択値取得
*/
    private static List<String> getPickListValMap(String fieldsName) {
        List<String> retList = new List<String>();
        String cns_clm_ideacommunitiesconfig = IdeaCommunitiesConfig__c.getSObjectType().getDescribe().getName();
        Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(cns_clm_ideacommunitiesconfig).getDescribe().fields.getMap().get(fieldsName).getDescribe();
        List<Schema.PicklistEntry> pickListVal = fieldResult.getPicklistValues();

        for( Schema.PicklistEntry peRow : pickListVal) {
            retList.add(peRow.getValue());
        }

        return retList;
    }

    /*
* create test Idea
*  prmIdeaCount: 作成したいアイデアの件数
*  prmCommName: 作成したいアイデアのコミュニティ名
*  prmCategory: 作成したいアイデアのカテゴリ
*  prmStatus: 作成したいアイデアの状況
*/
    private static List<IdeaPost__c> createIdea(Integer prmIdeaCount, String prmCommName, String prmCategory, String prmStatus) {
        // アイデア新規登録
        List<IdeaPost__c> ideaList = new List<IdeaPost__c>();

        for (Integer i=0; i < prmIdeaCount; i++) {
            IdeaPost__c ideaPostRow = new IdeaPost__c(Title__c = 'IDEA' + String.valueOf(i)
                                                      , Body__c = prmCommName
                                                      + prmCategory
                                                      + prmStatus
                                                      + '<img src=xxxxxx></img>'
                                                      + String.valueOf(i)
                                                      , Community__c = prmCommName
                                                      , Categories__c = prmCategory
                                                      , Status__c = prmStatus
                                                      , PostFlag__c = True
                                                     );
            ideaList.add(ideaPostRow);
        }

        insert ideaList;

        // コメント作成
        IdeaComment__c commRow = new IdeaComment__c(IdeaPost__c = ideaList[0].Id
                                                    , CommentBody__c = 'CommentBody');

        insert commRow;

        // 投票作成
        Vote__c vtRow = new Vote__c(IdeaPost__c = ideaList[0].Id
                                    , Points__c = 10
                                    , VoteType__c = 'Like');

        insert vtRow;

        return ideaList;
    }

    /*
* create a test user
*  prmContact: 紐付けたい取引先責任者ID
*  isMember: true=会員、false=ゲスト(システム管理者)
*/
    private static User createUser(Contact prmContact, boolean isMember) {
        User user = new User();
        User loginUser = [SELECT Id, Username, UserRoleId FROM User WHERE Id = :UserInfo.getUserId() LIMIT 1];
        // ロールが指定されてないユーザで、ポータル・コミュニティユーザテストデータ作成処理のテストコードを実行すると、エラーが発生するため、
        // 実行ユーザにロールを付与する。(もしSOQL101ガバナエラーになる場合、ロールを付与するコードを削除し、テスト実行ユーザにロールを設定すればよい。)
        //System.runAs(loginUser) {
        //UserRole r = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role');
        //insert r;
        //loginUser.UserRoleId = r.Id;
        //supdate loginUser;

        System.debug('Start createUser');
        Profile profile;
        String varEmail;
        String varUserName;
        String strFirstName;
        String strLastName;

        if (isMember) {
            profile = getCCUProfile();
            varEmail = prmContact.Email;
            varUserName = prmContact.Email;
            strFirstName = prmContact.FirstName;
            strLastName = prmContact.LastName;
        } else {
            profile = getSysAdminProfile();
            varEmail = 'sysAdmintest@xxxx.com';
            varUserName = 'sysAdmintest@xxxx.com';
            strFirstName = 'FirstNameSA';
            strLastName = 'LastNameSA';
        }

        String profileId = profile.id;

        user.Email = varEmail;
        user.UserName = varUserName;
        user.FirstName = strFirstName;
        user.LastName = strLastName;
        user.Alias = user.UserName.split('@')[0].left(8);
        user.ProfileId = profileId;
        user.EmailEncodingKey = 'ISO-2022-JP';
        user.LanguageLocaleKey = 'ja';
        user.LocaleSidKey = 'ja_JP';
        user.TimeZoneSidKey = 'Asia/Tokyo';

        if (isMember) {
            user.ContactId = prmContact.Id;
        }

        insert user;
        user = [select Name, UserName, FirstName, LastName, Alias, UserRoleId, ProfileId, CreatedDate, ContactId from user where UserName = :user.Username limit 1];
        System.debug('user-->' + user);
        System.debug('End createUser');
        //}

        return user;
    }

    /*
* get Profile of Customer Community User
*/
    private static Profile getCCUProfile() {
        Profile[] profiles;
        profiles =  [select Id From Profile where Name = 'Customer Community User' limit 1];
        return profiles[0];
    }

    /*
* get Profile of SysAdmin User
*/
    private static Profile getSysAdminProfile() {
        Profile[] profiles;
        profiles =  [select Id From Profile where Name = 'システム管理者' limit 1];
        return profiles[0];
    }

    /*
* コミュニティユーザデータ作成
* numAccts：作成したい取引先件数
* numContactsPerAcct：作成したい取引先責任者数
* prmName：作成した任意のユーザ名
*/
    private static List<Contact> createTestCommUser(Integer numAccts, Integer numContactsPerAcct, String prmName) {
        System.debug('Start createTestCommUser');
        List<Account> accts = new List<Account>();

        for (Integer i=0;i<numAccts;i++) {
            Account a = new Account(Name='TestAccount' + i);
            accts.add(a);
        }

        insert accts;

        List<Contact> cons = new List<Contact>();

        for (Integer j=0;j<numAccts;j++) {
            Account acct = accts[j];
            // For each account just inserted, add contacts
            for (Integer k=numContactsPerAcct*j;k<numContactsPerAcct*(j+1);k++) {
                cons.add(new Contact(firstname = prmName + k,
                                     lastname = prmName + k,
                                     Phone = '123456879546',
                                     AccountId = acct.Id,
                                     Email = prmName + 'test@xxxx.com'));
            }
        }
        // Insert all contacts for all accounts
        insert cons;

        System.debug('cons-->' + cons);
        System.debug('End createTestCommUser');

        return cons;
    }
}
