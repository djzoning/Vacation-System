<cfoutput>
	<li class="dropdown dropdown-user">
        <a href="javascript:;" class="dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-close-others="true">
            <img alt="" class="img-circle" src="/users/sessionUserImage" />
            <span class="username username-hide-on-mobile">#UcFirst(SESSION.user.username)#</span>
            <i class="fa fa-angle-down"></i>
        </a>
        <ul class="dropdown-menu dropdown-menu-default">
            <li>
                <a href="/Users/view/#SESSION.user.id#">
                    <i class="icon-user"></i> My Profile </a>
            </li>
            <li>
                <a href="Calendar/index/#SESSION.User.id#">
                    <i class="icon-calendar"></i> My Calendar </a>
            </li>
            <li>
                <a href="/dashboard/quickactions">
                    <i class="icon-envelope-open"></i> My Inbox
                    <span class="badge badge-danger">#arrayLen(prc.userNotifications)#</span>
                </a>
            </li>
            <li class="divider"> </li>
            <!---<li>
                <a href="page_user_lock_1.html">
                    <i class="icon-lock"></i> Lock Screen </a>
            </li>--->
            <li>
                <a href="#event.buildLink('Security.logout')#">
                    <i class="icon-key"></i> Log Out </a>
            </li>
        </ul>
    </li>
</cfoutput>