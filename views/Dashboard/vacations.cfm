<cfoutput>
    <div class="portlet portlet-sortable light">
        <div class="portlet-title">
            <div class="caption caption-md">
                <i class="icon-bar-chart font-dark hide"></i>
                <span class="caption-subject font-dark bold uppercase">Vacations</span>
            </div>
            <div class="actions">
                <div class="btn-group btn-group-devided" data-toggle="buttons">
                    <label class="btn btn-transparent green btn-outline btn-circle btn-sm active">
                        <input type="radio" name="options" class="toggle" id="today" value="today">Today</label>
                    <label class="btn btn-transparent green btn-outline btn-circle btn-sm">
                        <input type="radio" name="options" class="toggle" id="week" value="week">Week</label>
                    <label class="btn btn-transparent green btn-outline btn-circle btn-sm">
                        <input type="radio" name="options" class="toggle" id="month" value="month">Month</label>
                </div>
            </div>
        </div>
        <div id="dashboard-vacations" class="portlet-body">
            <cfinclude template="partials/vacationsTable.cfm">
        </div>
    </div>
</cfoutput>