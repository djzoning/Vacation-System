<cfoutput>
	<div class="row">
        <div class="col-md-12">
            <div class="portlet box blue portlet-fit calendar">
                <div class="portlet-title">
                    <div class="caption">
                        <i class="fa fa-calendar-o"></i>
                        <span class="caption-subject sbold">Calendar</span>
                    </div>
                </div>
                <div class="portlet-body">
                    <div class="row">
                        <div class="col-md-12">
                            <div data-spy="affix" data-offset-top="200">
                            	<div class="loader loader-absolute">Loading...</div>
                            </div>
							<div class="col-sm-3 col-md-2 filter-container">
								<cfinclude template="filter.cfm" />
							</div>
							<div class="col-sm-9 col-md-10 calendar-container">
								<div id="calendar"></div>
							</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
		var vacations = #args.vacations#;
	</script>
    
</cfoutput>
