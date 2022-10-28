// Copyright 2020 salesforce.com, inc
// All rights reserved.
// SPDX-License-Identifier: BSD-3-Clause
// For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

/**
* IE_IdeaMainController
* @Description: IE_IdeaMainコンポ―ネントコントロールクラス
*/
public with sharing class IE_IdeaMainController {
    /** 定数 */
    private static String namespace_prefix = '';
    private static String cns_voteType_positive = 'Like';
    private static String cns_voteType_negative = 'DisLike';
    private static String cns_strBlank = '';
    private static String cns_strSemicolon = ';';
    private static String cns_strNewLine = '\\n';
    private static String cns_clm_ideapost = 'IdeaPost__c';
    private static String cns_clm_ideacommunitiesconfig = 'IdeaCommunitiesConfig__c';
    private static String cns_clm_categories = 'Categories__c';
    private static String cns_clm_status = 'Status__c';
    private static String cns_clm_close = 'Close__c';
    private static String cns_clm_title = 'Title__c';
    private static String cns_clm_body = 'Body__c';
    private static String cns_clm_pointgrandtotal = 'PointGrandTotal__c';
    private static String cns_clm_postflag = 'PostFlag__c';
    private static String cns_clm_parentidea = 'ParentIdea__c';
    private static String cns_clm_community = 'Community__c';
    private static String cns_clm_like = 'like__c';
    private static String cns_clm_dislike = 'Dislike__c';
    private static String cns_clm_shownegativevote = 'ShowNegativeVote__c';
    private static String cns_clm_pagename = 'pageName__c';
    private static String cns_clm_enableanonymouspost = 'enableAnonymousPost__c';
    private static String cns_clm_configcommunity = 'Community__c';
    private static String cns_clm_configcategories = 'Categories__c';
    private static String cns_clm_configstattus = 'Status__c';
    private static String cns_clm_vote = 'Vote__c';
    private static String cns_clm_votetype = 'VoteType__c';
    private static String cns_clm_ideacomment = 'IdeaComment__c';
    private static String cns_clm_ideacommentideapost = 'IdeaPost__c';
    private static String cns_clm_pickup = 'Pickup__c';
    private static String cns_clm_commentbody = 'CommentBody__c';
    private static String cns_clm_points = Vote__c.Points__c.getDescribe().getName();
    private static String cns_clm_voteideapost = Vote__c.IdeaPost__c.getDescribe().getName();
    private static String cns_conditionInitialVal = Label.IE_Condition_Initial_Value;
    private static String cns_conditionMyIdea = Label.IE_Condition_MyIdea;
    private static String cns_sortValueTrend = Label.IE_Sort_Value_Trend;
    private static String cns_sortValueLatest = Label.IE_Sort_Value_Latest;
    private static String cns_sortValueClosed = Label.IE_Sort_Value_Closed;
    private static String cns_sortValueNewOrder = Label.IE_Sort_Value_New_Order;
    private static String cns_sortValueOldestFirst = Label.IE_Sort_Value_Oldest_First;
    private static String cns_communityInternalValue = Label.IE_Community_internal_Value;
    private static String getIdeaPostSql = 'SELECT Id, Title__c, Body__c, Categories__c, Close__c, tolabel(Status__c), CreatedById, CreatedBy.Name, PointGrandTotal__c, CreatedBy.SmallPhotoUrl,PostFlag__c,CreatedDate, Anonymous__c FROM '+cns_clm_ideapost;
    private static String getIdeaCommentCountSql = 'SELECT count() FROM IdeaComment__c where IdeaPost__c = :recordId';

    private static Void setClmName() {
        List<String> classNameParts = String.valueOf(IE_IdeaMainController.class).split('\\.', 2);

        if (classNameParts.size() > 0) {
	        namespace_prefix  = classNameParts[0];
        }

        //IdeaPost__c
        cns_clm_ideapost = IdeaPost__c.getSObjectType().getDescribe().getName();
        cns_clm_categories = IdeaPost__c.Categories__c.getDescribe().getName();
        cns_clm_status = IdeaPost__c.Status__c.getDescribe().getName();
        cns_clm_close = IdeaPost__c.Close__c.getDescribe().getName();
        cns_clm_title = IdeaPost__c.Title__c.getDescribe().getName();
        cns_clm_body = IdeaPost__c.Body__c.getDescribe().getName();
        cns_clm_pointgrandtotal = IdeaPost__c.PointGrandTotal__c.getDescribe().getName();
        cns_clm_postflag = IdeaPost__c.PostFlag__c.getDescribe().getName();
        cns_clm_parentidea = IdeaPost__c.ParentIdea__c.getDescribe().getName();
        cns_clm_community = IdeaPost__c.Community__c.getDescribe().getName();
        getIdeaPostSql = 'SELECT Id,'+cns_clm_title+','+cns_clm_body+','+cns_clm_categories+','+cns_clm_pointgrandtotal+','+cns_clm_postflag+', '+cns_clm_close+', tolabel('+cns_clm_status+'), CreatedById, CreatedBy.Name, CreatedBy.SmallPhotoUrl,CreatedDate,Anonymous__c FROM '+cns_clm_ideapost;

        //IdeaCommunitiesConfig__c
        cns_clm_ideacommunitiesconfig = IdeaCommunitiesConfig__c.getSObjectType().getDescribe().getName();
        cns_clm_like = IdeaCommunitiesConfig__c.Like__c.getDescribe().getName();
        cns_clm_dislike = IdeaCommunitiesConfig__c.Dislike__c.getDescribe().getName();
        cns_clm_shownegativevote = IdeaCommunitiesConfig__c.ShowNegativeVote__c.getDescribe().getName();
        cns_clm_pagename = IdeaCommunitiesConfig__c.pageName__c.getDescribe().getName();
        cns_clm_enableanonymouspost = IdeaCommunitiesConfig__c.enableAnonymousPost__c.getDescribe().getName();
        cns_clm_configcommunity = IdeaCommunitiesConfig__c.Community__c.getDescribe().getName();
        cns_clm_configcategories = IdeaCommunitiesConfig__c.Categories__c.getDescribe().getName();
        cns_clm_configstattus = IdeaCommunitiesConfig__c.Status__c.getDescribe().getName();

        //Vote
        cns_clm_vote = Vote__c.getSObjectType().getDescribe().getName();
        cns_clm_votetype = Vote__c.VoteType__c.getDescribe().getName();
        cns_clm_points = Vote__c.Points__c.getDescribe().getName();
        cns_clm_voteideapost = Vote__c.IdeaPost__c.getDescribe().getName();

        //IdeaComment__c
        cns_clm_ideacomment = IdeaComment__c.getSObjectType().getDescribe().getName();
        cns_clm_ideacommentideapost = IdeaComment__c.IdeaPost__c.getDescribe().getName();
        cns_clm_pickup = IdeaComment__c.Pickup__c.getDescribe().getName();
        cns_clm_commentbody = IdeaComment__c.CommentBody__c.getDescribe().getName();
    }

    /**
    * 以下コミュニティ情報を取得
    * 　・コミュニティ名
    * 　・コミュニティフラグ
    * 　・カテゴリリスト
    * 　・状況リスト
    * コミュニティページ以外の場合、空白を返す
    */
    @AuraEnabled
    public static CommunityInfo getCommunityInfo() {
        try {
            setClmName();
            CommunityInfo commInfo = new CommunityInfo();

            // コミュニティ名取得
            String communityName = getCommunityName();
            commInfo.communityName = communityName;

            // コミュニティ設定情報取得SOQL
            String strCommConfQuery = ' SELECT '+cns_clm_configcategories+', '+cns_clm_configstattus+','+cns_clm_like+','+cns_clm_dislike+','+cns_clm_shownegativevote+','+cns_clm_pagename+','+cns_clm_enableanonymouspost + ' FROM '+cns_clm_ideacommunitiesconfig+' WHERE '+cns_clm_configcommunity+' = :communityName LIMIT 1 ';
            List<IdeaCommunitiesConfig__c> IdeaConfList = Database.query(strCommConfQuery);

            if (IdeaConfList.size() > 0) {
                IdeaCommunitiesConfig__c IdeaConf = IdeaConfList[0];

                //初期値（All)を設定する
                PickListVal elementInitialVal = getPickListVal(cns_conditionInitialVal, cns_conditionInitialVal);

                // カテゴリリスト設定
                if (IdeaConf.Categories__c != null && IdeaConf.Categories__c != cns_strBlank) {
                    // コミュニティで使用するカテゴリ選択肢設定(モーダル)
                    List<PickListVal> categoryListModal = getAblePickList(cns_clm_configcategories, IdeaConf.Categories__c);
                    commInfo.categoryListModal = categoryListModal;

                    // コミュニティで使用するカテゴリ選択肢設定(一覧画面)
                    List<PickListVal> categoryList = new List<PickListVal>();
                    categoryList.addAll(categoryListModal);

                    //一覧画面の初期値(all)を挿入する
                    categoryList.add(0, elementInitialVal);
                    //一覧画面の初期値(私の投稿)を挿入する
                    PickListVal elementMyIdea = getPickListVal(cns_conditionMyIdea, cns_conditionMyIdea);
                    categoryList.add(elementMyIdea);

                    commInfo.categoryList = categoryList;
                }
                // 状況リスト設定
                if (IdeaConf.Status__c != null && IdeaConf.Status__c != cns_strBlank) {
                    // 状況で使用するカテゴリ選択肢設定
                    List<PickListVal> statusList = getAblePickList(cns_clm_configstattus, IdeaConf.Status__c);
                    //一覧画面の初期値(all)を挿入する
                    statusList.add(0, elementInitialVal);
                    commInfo.statusList = statusList;
                }
                //Set Like and Dislike point
                if (IdeaConf.Like__c != null && IdeaConf.Dislike__c != null) {
                    commInfo.likePoint = (Integer) IdeaConf.Like__c;
                    commInfo.dislikePoint = (Integer) IdeaConf.Dislike__c;
                }
                //Set Negative Vote Flag
                if (IdeaConf.ShowNegativeVote__c != null) {
                    commInfo.showNegativeVote = (Boolean) IdeaConf.ShowNegativeVote__c;
                }
                //Set List Page Name
                if (IdeaConf.pageName__c != null) {
                    if (namespace_prefix != NULL && !namespace_prefix.equalsIgnoreCase('')) {
	                    commInfo.pageName = (String) namespace_prefix + '__' +IdeaConf.pageName__c;
                    } else {
	                    commInfo.pageName = (String) IdeaConf.pageName__c;
                    }
                }
                // 匿名フラグ設定
                commInfo.enableAnonymousPost = IdeaConf.enableAnonymousPost__c;
            } else {
                throw new IEException(Label.IE_ErrMsg_NotExistIdeaConfigObj);
            }
            return commInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * アイデア詳細_
    */
    @AuraEnabled
    public static IdeaCellInfo getIdeaDetail(String recordId) {
        try {
            setClmName();
            String getIdeaPostSqlWhereLimit = getIdeaPostSql + ' WHERE Id = :recordId LIMIT 1';

            IdeaPost__c ideaRow = Database.query(getIdeaPostSqlWhereLimit);

            String UserId = UserInfo.getUserId();

            //urlでログインユーザの写真urlを取得
            User userInfo = Database.query('SELECT SmallPhotoUrl,Name FROM User WHERE User.ID = :UserId LIMIT 1');
            String LoginUserSmallPhotoUrl = userInfo.SmallPhotoUrl;
            String LoginUserName = userInfo.Name;
            List<Vote__c> voteList = Database.query('SELECT Id, '+cns_clm_votetype+','+cns_clm_points+' FROM '+cns_clm_vote+' WHERE createdById = :UserId and '+cns_clm_voteideapost+' = :recordId');
            IdeaCellInfo iri = new IdeaCellInfo();
            iri.isVoted = false;

            if (voteList.size() != 0) {
                iri.isVoted = true;

                //投票結果をチェックする
                iri.isPositive = false;

                if (voteList[0].VoteType__c.equals(cns_voteType_positive)) {
                    iri.isPositive = true;
                }
            }

            iri.recordId = recordId;
            iri.Points = String.valueOf(ideaRow.PointGrandTotal__c.format());
            iri.title = ideaRow.Title__c;
            iri.ideaBody = ideaRow.Body__c;
            iri.categories = ideaRow.Categories__c;
            iri.categoriesLabel = getPickListLabelName(cns_clm_categories, ideaRow.Categories__c); //画面表用のカテゴリラベル名設定
            iri.isPost = ideaRow.PostFlag__c;
            iri.isClosed = ideaRow.Close__c;
            iri.userName = LoginUserName;
            iri.photoUrl = LoginUserSmallPhotoUrl;
            iri.postUserName = ideaRow.Anonymous__c? System.Label.IE_Comment_Anonymous_Name : ideaRow.createdBy.Name;
            iri.postUserPhotoUrl = ideaRow.Anonymous__c? '': ideaRow.createdBy.SmallPhotoUrl;
            iri.userId = ideaRow.CreatedById;
            iri.status = ideaRow.Status__c;

            //作成日
            Datetime createdDate = ideaRow.CreatedDate;
            String createdDateChanged = createdDate.year() + '/' + createdDate.month() + '/' + createdDate.day();
            iri.createdDate = createdDateChanged;

            return iri;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * アイデア詳細_コメントを挿入する
    */
    @AuraEnabled
    public static void submitComment(String recordId, String ideaComment, Boolean anonymous) {
        try {
            setClmName();
            IdeaComment__c IdeaCommentObj = new IdeaComment__c();
            IdeaCommentObj.CommentBody__c = ideaComment;
            IdeaCommentObj.IdeaPost__c = recordId;
            IdeaCommentObj.Anonymous__c = anonymous;

            if (Schema.sObjectType.IdeaComment__c.isCreateable()) {
                insert IdeaCommentObj;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * ドラフトアイデアを削除する
    */
    @AuraEnabled
    public static void deleteDraftIdea(String recordId) {
        try {
            setClmName();
            IdeaPost__c deleteIdeaPostRow = new IdeaPost__c(Id = recordId);

            if (Schema.sObjectType.IdeaPost__c.isDeletable()) {
                delete deleteIdeaPostRow;
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * upsert(共通)
    */
    @AuraEnabled
    public static IdeaCellInfo pressLikeDislike(String recordId, String isLike, integer point) {
        try {
            setClmName();
            Vote__c vote = new Vote__c();
            String UserId = UserInfo.getUserId();
            List<Vote__c> votes = Database.query('SELECT Id, '+cns_clm_votetype+','+cns_clm_points+' FROM '+cns_clm_vote+' WHERE createdById = :UserId and '+cns_clm_voteideapost+' = :recordId');

            if (votes.size() > 0) {
                vote = votes[0];
            } else {
                vote.IdeaPost__c = recordId;
            }

            if (isLike.equals('delete') && Schema.sObjectType.Vote__c.isDeletable()) {
                delete vote;
            } else {
                vote.VoteType__c = isLike.equals('true') ? cns_voteType_positive : cns_voteType_negative;
                vote.Points__c = point;

                if (Schema.sObjectType.Vote__c.isCreateable() && Schema.sObjectType.Vote__c.isUpdateable()) {
                    upsert vote;
                }
            }

            IdeaCellInfo ideaCellInfo = getIdeaDetail(recordId);

            return ideaCellInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * 新規アイデアのinsertを行う
    */
    @AuraEnabled
    public static String submitIdea(String ideaTitleModal, String ideaBodyModal, List<String> categoryModal, Boolean isPost, String recordId, integer point, Boolean anonymous) {
        try {
            setClmName();
            String categoryModalString = '';

            for (String tmpString : categoryModal) {
                if (categoryModalString != '') {
                    categoryModalString += ';';
                }
                categoryModalString += tmpString;
            }

            String getIdeaPostSqlwhere = getIdeaPostSql + ' WHERE id = :recordId';

            List<IdeaPost__c> IdeaPostList = Database.query(getIdeaPostSqlwhere);

            //アイデア取得件数が0件の場合、エラー
            if (!String.isEmpty(recordId) && IdeaPostList.size() == 0) {
                throw new IEException(Label.IE_ErrMsg_Record_Unavailable);
            }

            IdeaPost__c ideaPost = new IdeaPost__c();
            ideaPost.Title__c = ideaTitleModal;
            ideaPost.Body__c = ideaBodyModal;
            ideaPost.Categories__c = categoryModalString;
            ideaPost.Anonymous__c = anonymous;

            //コミュニティ取得
            String communityName = getCommunityName();
            ideaPost.Community__c = communityName;
            ideaPost.PostFlag__c = isPost;

            SObjectAccessDecision decision;
            List<IdeaPost__c> securityIdeaPostList = new List<IdeaPost__c>();

            if (IdeaPostList.size() != 0) {
                //更新の場合(レコードが存在する場合には必ず更新になる)
                //id設定後更新を行う
                ideaPost.Id = IdeaPostList[0].Id;
                securityIdeaPostList.add(ideaPost);
                decision = Security.stripInaccessible(AccessType.UPDATABLE, securityIdeaPostList);
                update decision.getRecords();
            } else {
                //新規登録の場合
                ideaPost.Status__c = Label.IE_Status_Initial_Value;
                securityIdeaPostList.add(ideaPost);
                decision = Security.stripInaccessible(AccessType.CREATABLE, securityIdeaPostList);
                insert decision.getRecords();
            }

            return (String)ideaPost.Id;

            //公開時、投票を行う
            /*
            if (isPost) {
            pressLikeDislike(ideaPost.Id, 'true', point);
            }
            */
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * アイデア一覧取得処理
    * 初期表示件数はカスタム表示ラベル「Label.IE_Comment_Show_Number」から取得
    * 「さらに表示」を押下するとカスタム表示ラベルで設定された件数コメントが増える
    */
    @AuraEnabled
    public static IdeaCommentListInfo getCommentListInfo(String recordId, String selectedSort, Integer showCommentCount) {
        try {
            setClmName();
            //カスタム表示ラベルの表示数を設定する
            showCommentCount += Integer.valueOf(Label.IE_Comment_Show_Number);
            IdeaCommentListInfo ideaCommentListInfo = new IdeaCommentListInfo();
            //表示する予定の件数を設定する
            ideaCommentListInfo.showCommentCount = showCommentCount;

            //コメントのすべての長さ
            Integer commentCount = Database.countQuery(getIdeaCommentCountSql);
            ideaCommentListInfo.grandCommentCount = commentCount;

            String selectQuery = 'SELECT createdBy.Name, createdBy.SmallPhotoUrl,'+cns_clm_commentbody+',CreatedDate, Anonymous__c, '+cns_clm_pickup+' FROM '+ cns_clm_ideacomment + ' WHERE '+cns_clm_ideacommentideapost+' = :recordId ORDER BY CreatedDate';
            String selectQuerySort = ' ASC';

            if (selectedSort.equals(cns_sortValueNewOrder)) {
                selectQuerySort = ' DESC';
            }

            String selectQueryCount = '';
            if (commentCount > showCommentCount) {
                //画面上表示コメント数を設定
                selectQueryCount = ' LIMIT :showCommentCount';
            }

            List<IdeaComment__c> IdeaCommentList = new List<IdeaComment__c>();

            //画面上表示するコメントを取得する
            IdeaCommentList = Database.query(selectQuery + selectQuerySort + selectQueryCount);
            list<IdeaCommentBean> icbList = new List<IdeaCommentBean>();

            for (IdeaComment__c tmpIdeaComment : IdeaCommentList) {
                IdeaCommentBean icb = new IdeaCommentBean();
                Datetime createdDate = tmpIdeaComment.CreatedDate;
                String createdDateChanged = createdDate.year() + '/' + createdDate.month() + '/' + createdDate.day();

                icb.CreatedDate = createdDateChanged;
                icb.SmallPhotoUrl = tmpIdeaComment.Anonymous__c? '' : tmpIdeaComment.createdBy.SmallPhotoUrl;
                icb.Name = tmpIdeaComment.Anonymous__c? System.Label.IE_Comment_Anonymous_Name : tmpIdeaComment.createdBy.Name;
                icb.isPickup = tmpIdeaComment.Pickup__c;
                icb.CommentBody = tmpIdeaComment.CommentBody__c;
                icb.isAnonymous = tmpIdeaComment.Anonymous__c;
                icbList.add(icb);
            }

            ideaCommentListInfo.IdeaCommentBeanList = icbList;
            return ideaCommentListInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * アイデア一覧取得処理
    */
    @AuraEnabled
    public static IdeaListInfo getIdeaList(String category, String status, String sortVal, Integer showIdeaLimit, Integer offset) {
        try {
            setClmName();
            // ---　アイデア投稿オブジェクト取得クエリ生成　START ---
            // コミュニティ名取得
            String communityName = getCommunityName();

            //私の投稿の場合、マージされたアイデアも表示する
            // 条件クエリ作成
            String strConditionQuery = ' WHERE '+cns_clm_community+' = :communityName';
            //私の投稿の場合にはマージされたアイデアも含めて表示をする
            if (!category.equals(cns_conditionMyIdea)) {
                strConditionQuery = strConditionQuery + ' AND '+cns_clm_parentidea+' = null';
            }

            //私の投稿を検索するため、ログインユーザのidを取得
            String UserId = UserInfo.getUserId();
            String strConCategoryQuery = '';

            if (category != null && !String.isBlank(category)) {
                if (category.equals(cns_conditionInitialVal)) {
                    // カテゴリ値 = ALL
                    strConCategoryQuery = ' AND '+cns_clm_postflag+' = true';
                } else if (category.equals(cns_conditionMyIdea)) {
                    // カテゴリ値 = 私の投稿　※未公開アイデアも取得
                    strConCategoryQuery = ' AND CreatedById = : UserId ';
                } else {
                    // カテゴリ値 = 上記以外の選択値　
                    strConCategoryQuery = ' AND '+cns_clm_categories+' INCLUDES (: category) AND '+cns_clm_postflag+' = true ';
                }
            }

            String strStatusQuery = '';

            if (status != null && !String.isBlank(status) && status != cns_conditionInitialVal) {
                strStatusQuery = ' AND '+cns_clm_status+' = : status ';
            }

            String strOrderbyQuery;
            //ソート(トレンド、最新)、offsetの設定を行う
            if (sortVal != null && !String.isBlank(sortVal)) {
                if (sortVal.equals(cns_sortValueTrend)) {
                    strOrderbyQuery = ' ORDER BY '+cns_clm_close+' ASC, '+cns_clm_pointgrandtotal+' ';
                } else if (sortVal.equals(cns_sortValueClosed)) {
                    strOrderbyQuery = ' ORDER BY '+cns_clm_close+' DESC, CreatedDate ';
                } else {
                    strOrderbyQuery = ' ORDER BY '+cns_clm_close+' ASC, CreatedDate ';
                }
            }

            String strSortLimitOffsetQuery = ' DESC LIMIT :showIdeaLimit OFFSET :offset';
            // ---　アイデア投稿オブジェクト取得クエリ生成　END ---　

            // クエリ実行
            List<IdeaPost__c> ideaList = Database.query(getIdeaPostSql + strConditionQuery + strConCategoryQuery + strStatusQuery + strOrderbyQuery + strSortLimitOffsetQuery);
            List<IdeaPost__c> ideaListCnt = Database.query(getIdeaPostSql + strConditionQuery + strConCategoryQuery + strStatusQuery);

            //アイデアリスト、showIdeaLimit, offsetを返すリストを作成する
            IdeaListInfo ideaListInfo = new IdeaListInfo();
            IdeaListInfo.ideaCount = ideaListCnt.size();
            IdeaListInfo.showIdeaLimit = showIdeaLimit;
            IdeaListInfo.offset = offset;

            // アイデア取得件数=0
            if (ideaList == null) {
                //そのままリスト返却
                return ideaListInfo;
            }

            // マップ作成(実行ユーザが投票したアイデア毎の投票区分（Boolean）マップ)
            Map<Id, Boolean> voteTypeByIdeaMap = getVoteTypeMapByIdea();

            // アイデア一覧格納用
            List<IdeaCellInfo> cellList = new List<IdeaCellInfo>();

            // アイデアセル設定
            IdeaCellInfo ideaCell;
            for (IdeaPost__c iRow : ideaList) {
                ideaCell = new IdeaCellInfo();
                ideaCell.recordId = iRow.Id;
                ideaCell.title = iRow.Title__c;
                ideaCell.ideaBody = iRow.Body__c;
                ideaCell.points = String.valueOf(iRow.PointGrandTotal__c.format());
                ideaCell.status = iRow.Status__c;
                //匿名フラグ
                ideaCell.isAnonymous = iRow.Anonymous__c;
                //完了フラグ
                ideaCell.isClosed = iRow.Close__c;
                //カテゴリ情報
                ideaCell.categories = iRow.Categories__c;
                //　イメージURL
                if (iRow.CreatedBy.SmallPhotoUrl != null) {
                    ideaCell.photoUrl = iRow.Anonymous__c? '' : iRow.CreatedBy.SmallPhotoUrl;
                }
                ideaCell.userName = iRow.Anonymous__c? System.Label.IE_Comment_Anonymous_Name : iRow.CreatedBy.Name;
                //投票済アイデアの場合、投票区分を設定
                if (voteTypeByIdeaMap.containsKey(iRow.Id)) {
                    ideaCell.isVoted = true;
                    ideaCell.isPositive = voteTypeByIdeaMap.get(iRow.Id);
                }
                ideaCell.isPost = iRow.PostFlag__c;
                cellList.add(ideaCell);
            }
            // アイデア一覧
            IdeaListInfo.IdeaCellList = cellList;
            return IdeaListInfo;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    /**
    * コミュニティ情報保持
    * ・コミュニティフラグ
    * ・コミュニティ名
    */
    public class CommunityInfo {
        /** コミュニティ名 */
        @AuraEnabled
        public String communityName { get; set; }
        /** ログインユーザ、ゲストユーザを判断する */
        @AuraEnabled
        public Boolean isLoginUser { get; set; }
        /** カテゴリリスト */
        @AuraEnabled
        public List<PickListVal> categoryList { get; set; }
        /** カテゴリリストモーダル */
        @AuraEnabled
        public List<PickListVal> categoryListModal { get; set; }
        /** 状況リスト */
        @AuraEnabled
        public List<PickListVal> statusList { get; set; }
        /** Like Point */
        @AuraEnabled
        public Integer likePoint { get; set; }
        /** Dislike Point */
        @AuraEnabled
        public Integer dislikePoint { get; set; }
        /** Negative Vote Flag */
        @AuraEnabled
        public Boolean showNegativeVote { get; set; }
        /** List Page Name */
        @AuraEnabled
        public String pageName { get; set; }
        /** 匿名フラグ */
        @AuraEnabled
        public Boolean enableAnonymousPost { get; set; }
        CommunityInfo() {
            // 初期値設定
            communityName = cns_strBlank;
        }
    }

    /**
    * アイデアセルBean
    */
    public class IdeaCellInfo {
        /** アイデア_SFID */
        @AuraEnabled
        public String recordId { get; set; }
        /** アイデア_タイトル */
        @AuraEnabled
        public String title { get; set; }
        /** アイデア_内容 */
        @AuraEnabled
        public String ideaBody { get; set; }
        /** アイデア_ポイント */
        @AuraEnabled
        public String points { get; set; }
        /** アイデア_状況 */
        @AuraEnabled
        public String status { get; set; }
        /** アイデア_カテゴリ */
        @AuraEnabled
        public String categories { get; set; }
        /** アイデア_カテゴリ(ラベル名) */
        @AuraEnabled
        public String categoriesLabel { get; set; }
        /** アイデア_ユーザ小イメージ */
        @AuraEnabled
        public String photoUrl { get; set; }
        /** アイデア_ユーザ名 */
        @AuraEnabled
        public String userName { get; set; }
        /** アイデア_ユーザID */
        @AuraEnabled
        public String userId { get; set; }
        /** アイデア_作成日（投稿日） */
        @AuraEnabled
        public String createdDate { get; set; }
        /** アイデア_投票済 */
        @AuraEnabled
        public Boolean isVoted { get; set; }
        /** アイデア_ポジティブフラグ */
        @AuraEnabled
        public Boolean isPositive { get; set; }
        /** 完了を判断するフラグ */
        @AuraEnabled
        public Boolean isClosed { get; set; }
        /** isPostを判断するフラグ */
        @AuraEnabled
        public Boolean isPost { get; set; }
        /** 投稿者名前 */
        @AuraEnabled
        public String postUserName { get; set; }
        /** 投稿者ログイン写真 */
        @AuraEnabled
        public String postUserPhotoUrl { get; set; }
        /** 匿名フラグ */
        @AuraEnabled
        public Boolean isAnonymous { get; set; }

        IdeaCellInfo() {
            // 初期値設定
            isVoted = false;
            isClosed = false;
        }
    }
    /**
    * アイデア一覧情報Bean
    */
    public class IdeaListInfo {
        /** アイデア_SFID */
        @AuraEnabled
        public List<IdeaCellInfo> IdeaCellList { get; set; }
        /** 総アイデア件数 */
        @AuraEnabled
        public Integer ideaCount { get; set; }
        /** アイデア表示件数 */
        @AuraEnabled
        public Integer showIdeaLimit { get; set; }
        /** offset */
        @AuraEnabled
        public Integer offset { get; set; }
    }

    /**
    * アイデアコメント一覧情報Bean
    */
    public class IdeaCommentListInfo {
        /** アイデアコメント_SFID */
        @AuraEnabled
        public List<IdeaCommentBean> IdeaCommentBeanList { get; set; }
        /** コメント総件数 */
        @AuraEnabled
        public Integer grandCommentCount { get; set; }
        /** 表示しているコメントの件数 */
        @AuraEnabled
        public Integer showCommentCount { get; set; }
    }

    /**
    * アイデアコメントBean
    * 名何日前の情報を取得できないため、beanの作成を行う。
    */
    public class IdeaCommentBean {
        //写真
        @AuraEnabled
        public String SmallPhotoUrl { get; set; }
        //Pickup Flag
        @AuraEnabled
        public Boolean isPickup { get; set; }
        //名前
        @AuraEnabled
        public String Name { get; set; }
        //作成日
        @AuraEnabled
        public String CreatedDate { get; set; }
        //コメント
        @AuraEnabled
        public String CommentBody { get; set; }
        //匿名フラグ
        @AuraEnabled
        public Boolean isAnonymous { get; set; }

        IdeaCommentBean() {
            // 初期値設定
            isPickup = false;
        }
    }

    /**
    * コミュニティ名取得
    */
    private static String getCommunityName() {
        // コミュニティ情報取得
        Id commId = System.Network.getNetworkId();
        // コミュニティ名初期値：内部
        String retVal = cns_communityInternalValue;
        if (commId != null) {
            List<NetWork> nmList = Database.query('SELECT Name FROM NetWork WHERE Id = :commId');
            if (nmList.size() > 0 && nmList[0].Name != cns_strBlank) {
                retVal = nmList[0].Name;
            }
        }
        return retVal;
    }

    /**
    * アイデア毎投票区分取得
    */
    private static Map<Id, Boolean> getVoteTypeMapByIdea() {
        // 実行者が投票したアイデア取得
        String UserId = UserInfo.getUserId();
        List<Vote__c> voteList = Database.query('SELECT Id,'+cns_clm_voteideapost+',createdById,'+cns_clm_votetype+','+cns_clm_points+' FROM '+cns_clm_vote+' WHERE createdById = :UserId');

        // マップ作成(アイデア毎の投票区分マップ)
        Map<Id, Boolean> retMap = new Map<Id, Boolean>();
        for (Vote__c vRow : voteList) {
            Boolean blnVoteType = false;
            // Likeの場合
            if (vRow.VoteType__c != cns_strBlank && vRow.VoteType__c == cns_voteType_positive) {
                blnVoteType = true;
            }
            // アイデアId - 投票区分
            retMap.put(vRow.IdeaPost__c, blnVoteType);
        }
        return retMap;
    }

    /**
    * 「カテゴリ」及び「状況」の画面表示用選択リスト取得
    */
    private static List<PickListVal> getAblePickList(String fieldsName, String ablePickList) {
        // 項目で使用予定の選択肢リスト
        List<String> ableList = ablePickList.split(cns_strSemicolon);

        // すべての項目の中で、使用されている項目のみ取得する
        List<selectOption> pickListValList = getPickListValList(fieldsName, ableList);

        // selectOptionはLightningComponent上使用できないため、入れ替え用カスタムPickListValクラスを生成
        List<PickListVal> optionList = new List<PickListVal>();
        PickListVal option = null;

        //ソートを行う
        pickListValList.sort();

        //selectOption >> PickListVal入れ替えを行う
        for (selectOption tmpSelectOptionVal : pickListValList) {
            option = new PickListVal();
            //画面上表示される値、サーバー側で使用する値は両方getLabel()を設定する
            option.label = tmpSelectOptionVal.getLabel();
            option.value = tmpSelectOptionVal.getValue();
            optionList.add(option);
        }

        return optionList;
    }

    /**
    * 該当する選択値の中で使用される値のみ保持しているリスト生成
    */
    private static List<selectOption> getPickListValList(String fieldsName, List<String> ableList) {
        //すべての選択リストを取得する
        Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(cns_clm_ideapost).getDescribe().fields.getMap().get(fieldsName).getDescribe();
        List<Schema.PicklistEntry> pickListVal = fieldResult.getPicklistValues();

        //取得したすべての選択リストの中で、使用している選択リストのみ取得
        List<selectOption> retList = new List<selectOption>();

        for (Schema.PicklistEntry peRow : pickListVal) {
            if (ableList.contains(peRow.getValue())) {
                retList.add(new selectOption(peRow.getValue(), peRow.getLabel()));
            }
        }

        return retList;
    }

    /**
    * 選択リスト情報Bean
    * ・表示ラベル
    * ・値
    */
    public class PickListVal {
        /** 表示ラベル */
        @AuraEnabled
        public String label { get; set; }
        /** 値 */
        @AuraEnabled
        public String value { get; set; }
        PickListVal() {
            // 初期値設定
            label = cns_strBlank;
            value = cns_strBlank;
        }
    }

    /**
    * pickval作成
    */
    private static PickListVal getPickListVal(String label, String value) {
        PickListVal element = new PickListVal();
        element.label = label;
        element.value = value;

        return element;
    }

    /**
    * API名からラベル名変換
    */
    private static String getPickListLabelName(String clmName, String prmVal) {
        String retVal = prmVal;
        List<PickListVal> pickListValList = getAblePickList(clmName, retVal);
        //API名をラベル名に置換
        for (PickListVal e : pickListValList) {
            retVal = retVal.replace(e.value, e.label);
        }
        return retVal;
    }
}
