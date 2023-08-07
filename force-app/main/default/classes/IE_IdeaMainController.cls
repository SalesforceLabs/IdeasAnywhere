//  Copyright (c) 2023, salesforce.com, inc.
//  All rights reserved.
//  SPDX-License-Identifier: BSD-3-Clause
//  For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause

/**
* IE_IdeaMainController
* @Description: IE_IdeaMainコンポ―ネントコントロールクラス
*/
public with sharing class IE_IdeaMainController {
    /** 定数 */
    private static String NAMESPACE_PREFIX = '';
    private static String CNS_VOTETYPE_POSITIVE = 'Like';
    private static String CNS_VOTETYPE_NEGATIVE = 'DisLike';
    private static String CNS_STR_BLANK = '';
    private static String CNS_STR_SEMICOLON = ';';
    private static String CNS_STR_NEWLINE = '\\n';
    private static String CNS_CLI_IDEAPOST = 'IdeaPost__c';
    private static String CNS_CLM_IDEACOMMUNITIESCONFIG = 'IdeaCommunitiesConfig__c';
    private static String CNS_CLM_CATEGORIES = 'Categories__c';
    private static String CNS_CLM_STATUS = 'Status__c';
    private static String CNS_CLM_CLOSE = 'Close__c';
    private static String CNS_CLM_TITLE = 'Title__c';
    private static String CNS_CLM_BODY = 'Body__c';
    private static String CNS_CLM_POINTGRANDTOTAL = 'PointGrandTotal__c';
    private static String CNS_CLM_POSTFLAG = 'PostFlag__c';
    private static String CNS_CLM_PARENTIDEA = 'ParentIdea__c';
    private static String CNS_CLM_COMMUNITY = 'Community__c';
    private static String CNS_CLM_LIKE = 'like__c';
    private static String CNS_CLM_DISLIKE = 'Dislike__c';
    private static String CNS_CLM_SHOWNEGATIVEVOTE = 'ShowNegativeVote__c';
    private static String CNS_CLM_PAGENAME = 'pageName__c';
    private static String CNS_CLM_ENABLEANONYMOUSPOST = 'enableAnonymousPost__c';
    private static String CNS_CLM_COMFIGCOMMUNITY = 'Community__c';
    private static String CNS_CLM_COMFIGCATEGORIES = 'Categories__c';
    private static String CNS_CLM_COMFIGSTATUS = 'Status__c';
    private static String CNS_CLM_VOTE = 'Vote__c';
    private static String CNS_CLM_VOTETYPE = 'VoteType__c';
    private static String CNS_CLM_IDEACOMMENT = 'IdeaComment__c';
    private static String CNS_CLM_IDEACOMMENT_IDEAPOST = 'IdeaPost__c';
    private static String CNS_CLM_PICKUP = 'Pickup__c';
    private static String CNS_CLM_COMMENTBODY = 'CommentBody__c';
    private static String CNS_CLM_POINTS = Vote__c.Points__c.getDescribe().getName();
    private static String CNS_CLM_VOTEIDEAPOST = Vote__c.IdeaPost__c.getDescribe().getName();
    private static String CNS_CONDITiONINITIALVAL = Label.IE_Condition_Initial_Value;
    private static String CNS_CONDITiONMYIDEA = Label.IE_Condition_MyIdea;
    private static String CNS_SORTVALUE_TREND = Label.IE_Sort_Value_Trend;
    private static String CNS_SORTVALUE_LATEST = Label.IE_Sort_Value_Latest;
    private static String CNS_SORTVALUE_CLOSED = Label.IE_Sort_Value_Closed;
    private static String CNS_SORTVALUE_NEWORDER = Label.IE_Sort_Value_New_Order;
    private static String CNS_SORTVALUE_OLDESTFIRST = Label.IE_Sort_Value_Oldest_First;
    private static String CNS_COMMUNITY_INTERNALVALUE = Label.IE_Community_internal_Value;
    private static String GET_IDEAPOST_SQL = 'SELECT Id, Title__c, Body__c, Categories__c, Close__c, tolabel(Status__c), CreatedById, CreatedBy.Name, PointGrandTotal__c, CreatedBy.SmallPhotoUrl,PostFlag__c,CreatedDate, Anonymous__c FROM '+CNS_CLI_IDEAPOST;
    private static String getIdeaCommentCountSql = 'SELECT count() FROM IdeaComment__c where IdeaPost__c = :recordId';

    private static Void setClmName() {
        List<String> classNameParts = String.valueOf(IE_IdeaMainController.class).split('\\.', 2);

        if (classNameParts.size() > 1) {
	        NAMESPACE_PREFIX  = classNameParts[0];
        }

        //IdeaPost__c
        CNS_CLI_IDEAPOST = IdeaPost__c.getSObjectType().getDescribe().getName();
        CNS_CLM_CATEGORIES = IdeaPost__c.Categories__c.getDescribe().getName();
        CNS_CLM_STATUS = IdeaPost__c.Status__c.getDescribe().getName();
        CNS_CLM_CLOSE = IdeaPost__c.Close__c.getDescribe().getName();
        CNS_CLM_TITLE = IdeaPost__c.Title__c.getDescribe().getName();
        CNS_CLM_BODY = IdeaPost__c.Body__c.getDescribe().getName();
        CNS_CLM_POINTGRANDTOTAL = IdeaPost__c.PointGrandTotal__c.getDescribe().getName();
        CNS_CLM_POSTFLAG = IdeaPost__c.PostFlag__c.getDescribe().getName();
        CNS_CLM_PARENTIDEA = IdeaPost__c.ParentIdea__c.getDescribe().getName();
        CNS_CLM_COMMUNITY = IdeaPost__c.Community__c.getDescribe().getName();
        GET_IDEAPOST_SQL = 'SELECT Id,'+CNS_CLM_TITLE+','+CNS_CLM_BODY+','+CNS_CLM_CATEGORIES+','+CNS_CLM_POINTGRANDTOTAL+','+CNS_CLM_POSTFLAG+', '+CNS_CLM_CLOSE+', tolabel('+CNS_CLM_STATUS+'), CreatedById, CreatedBy.Name, CreatedBy.SmallPhotoUrl,CreatedDate,Anonymous__c FROM '+CNS_CLI_IDEAPOST;

        //IdeaCommunitiesConfig__c
        CNS_CLM_IDEACOMMUNITIESCONFIG = IdeaCommunitiesConfig__c.getSObjectType().getDescribe().getName();
        CNS_CLM_LIKE = IdeaCommunitiesConfig__c.Like__c.getDescribe().getName();
        CNS_CLM_DISLIKE = IdeaCommunitiesConfig__c.Dislike__c.getDescribe().getName();
        CNS_CLM_SHOWNEGATIVEVOTE = IdeaCommunitiesConfig__c.ShowNegativeVote__c.getDescribe().getName();
        CNS_CLM_PAGENAME = IdeaCommunitiesConfig__c.pageName__c.getDescribe().getName();
        CNS_CLM_ENABLEANONYMOUSPOST = IdeaCommunitiesConfig__c.enableAnonymousPost__c.getDescribe().getName();
        CNS_CLM_COMFIGCOMMUNITY = IdeaCommunitiesConfig__c.Community__c.getDescribe().getName();
        CNS_CLM_COMFIGCATEGORIES = IdeaCommunitiesConfig__c.Categories__c.getDescribe().getName();
        CNS_CLM_COMFIGSTATUS = IdeaCommunitiesConfig__c.Status__c.getDescribe().getName();

        //Vote
        CNS_CLM_VOTE = Vote__c.getSObjectType().getDescribe().getName();
        CNS_CLM_VOTETYPE = Vote__c.VoteType__c.getDescribe().getName();
        CNS_CLM_POINTS = Vote__c.Points__c.getDescribe().getName();
        CNS_CLM_VOTEIDEAPOST = Vote__c.IdeaPost__c.getDescribe().getName();

        //IdeaComment__c
        CNS_CLM_IDEACOMMENT = IdeaComment__c.getSObjectType().getDescribe().getName();
        CNS_CLM_IDEACOMMENT_IDEAPOST = IdeaComment__c.IdeaPost__c.getDescribe().getName();
        CNS_CLM_PICKUP = IdeaComment__c.Pickup__c.getDescribe().getName();
        CNS_CLM_COMMENTBODY = IdeaComment__c.CommentBody__c.getDescribe().getName();
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
            String strCommConfQuery = ' SELECT '+CNS_CLM_COMFIGCATEGORIES+', '+CNS_CLM_COMFIGSTATUS+','+CNS_CLM_LIKE+','+CNS_CLM_DISLIKE+','+CNS_CLM_SHOWNEGATIVEVOTE+','+CNS_CLM_PAGENAME+','+CNS_CLM_ENABLEANONYMOUSPOST + ' FROM '+CNS_CLM_IDEACOMMUNITIESCONFIG+' WHERE '+CNS_CLM_COMFIGCOMMUNITY+' = :communityName LIMIT 1 ';
            List<IdeaCommunitiesConfig__c> IdeaConfList = Database.query(strCommConfQuery);

            if (IdeaConfList.size() > 0) {
                IdeaCommunitiesConfig__c IdeaConf = IdeaConfList[0];

                //初期値（All)を設定する
                PickListVal elementInitialVal = getPickListVal(CNS_CONDITiONINITIALVAL, CNS_CONDITiONINITIALVAL);

                // カテゴリリスト設定
                if (IdeaConf.Categories__c != null && IdeaConf.Categories__c != CNS_STR_BLANK) {
                    // コミュニティで使用するカテゴリ選択肢設定(モーダル)
                    List<PickListVal> categoryListModal = getAblePickList(CNS_CLM_COMFIGCATEGORIES, IdeaConf.Categories__c);
                    commInfo.categoryListModal = categoryListModal;

                    // コミュニティで使用するカテゴリ選択肢設定(一覧画面)
                    List<PickListVal> categoryList = new List<PickListVal>();
                    categoryList.addAll(categoryListModal);

                    //一覧画面の初期値(all)を挿入する
                    categoryList.add(0, elementInitialVal);
                    //一覧画面の初期値(私の投稿)を挿入する
                    PickListVal elementMyIdea = getPickListVal(CNS_CONDITiONMYIDEA, CNS_CONDITiONMYIDEA);
                    categoryList.add(elementMyIdea);

                    commInfo.categoryList = categoryList;
                }
                // 状況リスト設定
                if (IdeaConf.Status__c != null && IdeaConf.Status__c != CNS_STR_BLANK) {
                    // 状況で使用するカテゴリ選択肢設定
                    List<PickListVal> statusList = getAblePickList(CNS_CLM_COMFIGSTATUS, IdeaConf.Status__c);
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
                    if (NAMESPACE_PREFIX != NULL && !NAMESPACE_PREFIX.equalsIgnoreCase('')) {
	                    commInfo.pageName = (String) NAMESPACE_PREFIX + '__' +IdeaConf.pageName__c;
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
            String GET_IDEAPOST_SQLWhereLimit = GET_IDEAPOST_SQL + ' WHERE Id = :recordId LIMIT 1';

            IdeaPost__c ideaRow = Database.query(GET_IDEAPOST_SQLWhereLimit);

            String UserId = UserInfo.getUserId();

            //urlでログインユーザの写真urlを取得
            User userInfo = Database.query('SELECT SmallPhotoUrl,Name FROM User WHERE User.ID = :UserId LIMIT 1');
            String LoginUserSmallPhotoUrl = userInfo.SmallPhotoUrl;
            String LoginUserName = userInfo.Name;
            List<Vote__c> voteList = Database.query('SELECT Id, '+CNS_CLM_VOTETYPE+','+CNS_CLM_POINTS+' FROM '+CNS_CLM_VOTE+' WHERE createdById = :UserId and '+CNS_CLM_VOTEIDEAPOST+' = :recordId');
            IdeaCellInfo iri = new IdeaCellInfo();
            iri.isVoted = false;

            if (voteList.size() != 0) {
                iri.isVoted = true;

                //投票結果をチェックする
                iri.isPositive = false;

                if (voteList[0].VoteType__c.equals(CNS_VOTETYPE_POSITIVE)) {
                    iri.isPositive = true;
                }
            }

            iri.recordId = recordId;
            iri.Points = String.valueOf(ideaRow.PointGrandTotal__c.format());
            iri.title = ideaRow.Title__c;
            iri.ideaBody = ideaRow.Body__c;
            iri.categories = ideaRow.Categories__c;
            iri.categoriesLabel = getPickListLabelName(CNS_CLM_CATEGORIES, ideaRow.Categories__c); //画面表用のカテゴリラベル名設定
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
            List<Vote__c> votes = Database.query('SELECT Id, '+CNS_CLM_VOTETYPE+','+CNS_CLM_POINTS+' FROM '+CNS_CLM_VOTE+' WHERE createdById = :UserId and '+CNS_CLM_VOTEIDEAPOST+' = :recordId');

            if (votes.size() > 0) {
                vote = votes[0];
            } else {
                vote.IdeaPost__c = recordId;
            }

            if (isLike.equals('delete') && Schema.sObjectType.Vote__c.isDeletable()) {
                delete vote;
            } else {
                vote.VoteType__c = isLike.equals('true') ? CNS_VOTETYPE_POSITIVE : CNS_VOTETYPE_NEGATIVE;
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

            String GET_IDEAPOST_SQLwhere = GET_IDEAPOST_SQL + ' WHERE id = :recordId';

            List<IdeaPost__c> IdeaPostList = Database.query(GET_IDEAPOST_SQLwhere);

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

            String selectQuery = 'SELECT createdBy.Name, createdBy.SmallPhotoUrl,'+CNS_CLM_COMMENTBODY+',CreatedDate, Anonymous__c, '+CNS_CLM_PICKUP+' FROM '+ CNS_CLM_IDEACOMMENT + ' WHERE '+CNS_CLM_IDEACOMMENT_IDEAPOST+' = :recordId ORDER BY CreatedDate';
            String selectQuerySort = ' ASC';

            if (selectedSort.equals(CNS_SORTVALUE_NEWORDER)) {
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
            String strConditionQuery = ' WHERE '+CNS_CLM_COMMUNITY+' = :communityName';
            //私の投稿の場合にはマージされたアイデアも含めて表示をする
            if (!category.equals(CNS_CONDITiONMYIDEA)) {
                strConditionQuery = strConditionQuery + ' AND '+CNS_CLM_PARENTIDEA+' = null';
            }

            //私の投稿を検索するため、ログインユーザのidを取得
            String UserId = UserInfo.getUserId();
            String strConCategoryQuery = '';

            if (category != null && !String.isBlank(category)) {
                if (category.equals(CNS_CONDITiONINITIALVAL)) {
                    // カテゴリ値 = ALL
                    strConCategoryQuery = ' AND '+CNS_CLM_POSTFLAG+' = true';
                } else if (category.equals(CNS_CONDITiONMYIDEA)) {
                    // カテゴリ値 = 私の投稿　※未公開アイデアも取得
                    strConCategoryQuery = ' AND CreatedById = : UserId ';
                } else {
                    // カテゴリ値 = 上記以外の選択値　
                    strConCategoryQuery = ' AND '+CNS_CLM_CATEGORIES+' INCLUDES (: category) AND '+CNS_CLM_POSTFLAG+' = true ';
                }
            }

            String strStatusQuery = '';

            if (status != null && !String.isBlank(status) && status != CNS_CONDITiONINITIALVAL) {
                strStatusQuery = ' AND '+CNS_CLM_STATUS+' = : status ';
            }

            String strOrderbyQuery;
            //ソート(トレンド、最新)、offsetの設定を行う
            if (sortVal != null && !String.isBlank(sortVal)) {
                if (sortVal.equals(CNS_SORTVALUE_TREND)) {
                    strOrderbyQuery = ' ORDER BY '+CNS_CLM_POINTGRANDTOTAL+' DESC, CreatedDate DESC NULLS LAST ';
                } else if (sortVal.equals(CNS_SORTVALUE_CLOSED)) {
                    strOrderbyQuery = ' ORDER BY '+CNS_CLM_CLOSE+' DESC, CreatedDate DESC NULLS LAST ';
                } else {
                    strOrderbyQuery = ' ORDER BY CreatedDate DESC NULLS LAST ';
                }
            }

            String strSortLimitOffsetQuery = ' LIMIT :showIdeaLimit OFFSET :offset';
            // ---　アイデア投稿オブジェクト取得クエリ生成　END ---　

            // クエリ実行
            List<IdeaPost__c> ideaList = Database.query(GET_IDEAPOST_SQL + strConditionQuery + strConCategoryQuery + strStatusQuery + strOrderbyQuery + strSortLimitOffsetQuery);
            List<IdeaPost__c> ideaListCnt = Database.query(GET_IDEAPOST_SQL + strConditionQuery + strConCategoryQuery + strStatusQuery);

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
            communityName = CNS_STR_BLANK;
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
        String retVal = CNS_COMMUNITY_INTERNALVALUE;
        if (commId != null) {
            List<NetWork> nmList = Database.query('SELECT Name FROM NetWork WHERE Id = :commId');
            if (nmList.size() > 0 && nmList[0].Name != CNS_STR_BLANK) {
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
        List<Vote__c> voteList = Database.query('SELECT Id,'+CNS_CLM_VOTEIDEAPOST+',createdById,'+CNS_CLM_VOTETYPE+','+CNS_CLM_POINTS+' FROM '+CNS_CLM_VOTE+' WHERE createdById = :UserId');

        // マップ作成(アイデア毎の投票区分マップ)
        Map<Id, Boolean> retMap = new Map<Id, Boolean>();
        for (Vote__c vRow : voteList) {
            Boolean blnVoteType = false;
            // Likeの場合
            if (vRow.VoteType__c != CNS_STR_BLANK && vRow.VoteType__c == CNS_VOTETYPE_POSITIVE) {
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
        List<String> ableList = ablePickList.split(CNS_STR_SEMICOLON);

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
        Schema.DescribeFieldResult fieldResult = Schema.getGlobalDescribe().get(CNS_CLI_IDEAPOST).getDescribe().fields.getMap().get(fieldsName).getDescribe();
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
            label = CNS_STR_BLANK;
            value = CNS_STR_BLANK;
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
