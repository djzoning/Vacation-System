<cfoutput>
	<div class="portlet light ">
        <div class="portlet-title tabbable-line">
            <div class="caption">
                <i class="icon-bubbles font-dark hide"></i>
                <span class="caption-subject font-dark bold uppercase">#prc.actionsTo# Actions</span>
            </div>
        </div>
        <div class="portlet-body">
            <div class="mt-comments">
            	<cfloop array="#prc.actions#" index="action">
            		<div class="mt-comment no-padding">
                        <div class="mt-comment-img">
                            <img src="/users/getImage?image=#action.getUser().getImage()#"> </div>
                        <div class="mt-comment-body">
                            <div class="mt-comment-info">
                                <span class="mt-comment-author">#action.getUser().getFirstName()# #action.getUser().getLastName()#</span>
                                <span class="mt-comment-date">#displayDateDiff(action.getTimestamp())#</span>
                            </div>
                            <div class="mt-comment-details no-margin">
                                <a href="/#action.getHandler()#/view/#action.getObjectId()#">
                                    <span class="mt-comment-status">#ucfirst(action.getObjectAction())# #ucfirst(action.getObjectName())#</span>
                                </a>
                            </div>
                        </div>
                    </div>
				</cfloop>
            </div>
        </div>
    </div>
</cfoutput>