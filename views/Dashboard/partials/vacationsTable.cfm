<cfoutput>
        <div class="table-scrollable table-scrollable-borderless">
        <table class="table table-hover table-light">
            <thead>
                <tr class="uppercase">
                    <th colspan="2">MEMBER</th>
                    <th>Team</th>
                    <th>From</th>
                    <th>To</th>
                    <th>Type</th>
                </tr>
            </thead>
            <tbody id="vacations">
                <cfloop array="#prc.vacations#" index="vacation">
                    <tr>
                        <td class="fit">
                            <img class="user-pic rounded" src="/users/getImage?image=#vacation.getUser().getImage()#">
                        </td>
                        <td>
                            <a href="javascript:;" class="primary-link">#vacation.getUser().getFirstName()#</a>
                        </td>
                        <td>#vacation.getUser().getTeam().getName()#</td>
                        <td>#dateFormat(vacation.getFromDate())#</td>
                        <td>#dateFormat(vacation.getToDate())#</td>
                        <td>
                            <span class="bold theme-font">#vacation.getType().getName()#</span>
                        </td>
                    </tr>
                </cfloop>
            </tbody>
        </table>
    </div>
</cfoutput>