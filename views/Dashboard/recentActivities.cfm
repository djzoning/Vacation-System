<cfoutput>
	<div class="portlet portlet-sortable light">
        <div class="portlet-title">
            <div class="caption">
                <i class="icon-share font-dark hide"></i>
                <span class="caption-subject font-dark bold uppercase">Recent Activities</span>
            </div>
        </div>
        <div class="portlet-body">
            <ul class="feeds">
            	<cfloop array="#prc.userActions#" index="action">
                    <li>
                        <a href="/#action.getHandler()#/view/#action.getObjectId()#">
                        <div class="col1">
                            <div class="cont">
                                <div class="cont-col1">
                                    <div class="label label-sm label-info">
                                        <cfset iconName = "plane">
                                    	
                                    	<cfif action.getObjectName() EQ 'Users'>
                                        	<cfset iconName = "user">
                                    	</cfif>
                                        <i class="fa fa-#iconName#"></i>
                                    </div>
                                </div>
                                <div class="cont-col2">
                                    <div class="desc">
										#ucfirst(action.getObjectAction())# #ucfirst(action.getObjectName())#
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col2 bigger">
                            <div class="date">
                            	#displayDateDiff(action.getTimestamp())#
                            </div>
                        </div>
                        </a>
                    </li>
                </cfloop>
            </ul>
        </div>
        <cfif structKeyExists(prc,"withFooter") AND arrayLen(prc.userActions) GT 0>
            <div class="scroller-footer">
                <div class="btn-arrow-link pull-right">
                <a href="/dashboard/recentActivities">See All Records</a>
                <i class="icon-arrow-right"></i>
                </div>
            </div>
        </cfif>
    </div>
</cfoutput>