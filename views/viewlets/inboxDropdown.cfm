<cfoutput>
    <li class="dropdown dropdown-extended dropdown-inbox" id="header_inbox_bar">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <cfset encelopeOpenClass = "">
            <cfif arrayLen(prc.userNotifications) GT 0>
                <cfset encelopeOpenClass = "-open">
            </cfif>

            <i class="icon-envelope#encelopeOpenClass#"></i>
            <cfif arrayLen(prc.userNotifications) GT 0>
                <span class="badge badge-default"> #arrayLen(prc.userNotifications)# </span>
            </cfif>
        </a>
        <ul class="dropdown-menu">
            <li class="external">
                <h3>You have
                    <span class="bold">#arrayLen(prc.userNotifications)# New</span> Messages</h3>
                <a href="/dashboard/quickactions">view all</a>
            </li>
            <cfif arrayLen(prc.userNotifications) GT 0>
                <li>
                    <ul class="dropdown-menu-list scroller" style="height: 275px;" data-handle-color="##637283">
                        <cfloop array="#prc.userNotifications#" index="notification">
                            <li>
                                <a href="##">
                                    <span class="photo">
                                        <img src="/users/getImage?image=#notification.getUser().getImage()#" class="img-circle" alt=""> </span>
                                    <span class="subject">
                                        <span class="from">#notification.getUser().getFirstName()# #notification.getUser().getLastName()#</span>
                                    </span>
                                    
                                    <cfif notification.getStatus().getName() EQ "Fill-in Approved">
                                        <span class="message">Team lead approval request</span>
                                    <cfelseif notification.getStatus().getName() EQ "Team Lead Approved">
                                        <span class="message">Manager approval request</span>
                                    <cfelse>
                                        <span class="message">Fill-in request</span>
                                    </cfif>
                                </a>
                            </li>
                        </cfloop>
                    </ul>
                </li>
            </cfif>
        </ul>
    </li>
</cfoutput>