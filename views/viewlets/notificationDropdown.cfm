<cfoutput>
	<li class="dropdown dropdown-extended dropdown-notification" id="header_notification_bar">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <i class="icon-bell"></i>
            <cfif arrayLen(prc.notifications) GT 0>
	            <span class="badge badge-default">#arrayLen(prc.notifications)#</span>
            </cfif>
        </a>
        <ul class="dropdown-menu">
            <li class="external">
                <h3>
                    <span class="bold">#arrayLen(prc.notifications)# pending</span> notifications</h3>
                <a href="page_user_profile_1.html">view all</a>
            </li>
            <li>
                <ul class="dropdown-menu-list scroller" style="height: 250px;" data-handle-color="##637283">
                    <cfloop array="#prc.notifications#" index="notification">
	                    <li>
	                        <a href="javascript:;">
	                            <span class="time">
	                            	<!--- TODO --->
	                                <!--- #displayDateDiff(prc.notification.timeSpan)# --->
	                            </span>
	                            <span class="details">
	                                <span class="label label-sm label-icon label-success">
	                                    <i class="fa fa-plus"></i>
	                                </span> 
	                                <!--- TODO --->
	                                <!--- #prc.notification.message# --->
	                            </span>
	                        </a>
	                    </li>
                    </cfloop>
                </ul>
            </li>
        </ul>
    </li>
</cfoutput>