component persistent="true" table="Vacation" extends="cborm.models.ActiveEntity"  {
	// Primary Key
	property name="id" fieldtype="id" column="id" generator="native" setter="false";
	// Properties
	property name = "fromDate" 			ormtype = "date";
	property name = "toDate" 			ormtype = "date";
	property name = "length" 			ormtype = "int";
	property name = "description" 		ormtype = "string";
	property name = "isActive" 			ormtype = "boolean" default = "1";
	property name = "rejectedMessage" 	ormtype = "string"  default = "";

	property name = "deputy" cfc = "User" fieldtype = "many-to-one" fkcolumn = "deputyId";
	property name = "user" cfc = "User" fieldtype = "many-to-one" fkcolumn = "userId";
	property name = "type" cfc = "VacationType" fieldtype = "many-to-one" fkcolumn = "typeId";
	property name = "status" cfc = "VacationStatus" fieldtype = "many-to-one" fkcolumn = "statusId";
	
	// Validation
	this.constraints = {
		fromDate = { required = true },
		toDate = { 
			required = true, 
			discrete = "gte:fromDate", 
			discreteMessage = "'To' date can not be before the 'From' date. " 
		},
		user = { required = true },
		deputy = { required = true },
		type = { required = true }
	};
	
	// Constructor
	function init(){
		super.init( useQueryCaching="false" );
		return this;
	}

	function getTodayVacations() {
		var criteria = this.newCriteria();
		var todayVacations = criteria
			.createAlias('status', 'status')
			.AND(
				criteria.restrictions.ge('toDate', now()),
				criteria.restrictions.isle('fromDate', now()),
				criteria.restrictions.OR(
					criteria.restrictions.eq('status.name', 'Team Lead Approved'),
					criteria.restrictions.eq('status.name','Manager Approved')
				)
			)
			.list();

		return todayVacations;
	}

	function getThisWeeksVacations() {
		var fisrtDayOfWeek = this.getFirstDayOfWeek(now());
		var lastDayOfWeek = this.getLastDayOfWeek(fisrtDayOfWeek);
		var thisWeekVacations = this.getApprovedVacationsBetween(fisrtDayOfWeek, lastDayOfWeek);
		
		return thisWeekVacations;
	}

	function getThisMonthsVacations() {
		var thisMonth = Month(now());
		var thisYear = Year(now());
		var startDate = CreateDate(thisYear, thisMonth, 1);
		var endDate = CreateDate(thisYear, thisMonth, daysInMonth(thisMonth));		
		var thisMonthVacations = this.getApprovedVacationsBetween(startDate, endDate);

		return thisMonthVacations;
	}

	function getApprovedVacationsBetween(startDate, endDate) {
		var criteria = this.newCriteria();
		var vacations = criteria
			.createAlias('status', 'status')
			.AND(
				criteria.restrictions.OR(
					criteria.restrictions.between('fromDate', startDate, endDate),
					criteria.restrictions.between('toDate', startDate, endDate)
				),
				criteria.restrictions.OR(
					criteria.restrictions.eq('status.name', 'Team Lead Approved'),
					criteria.restrictions.eq('status.name', 'Manager Approved')
				)
			)			
			.list();

		return vacations;
	}

	function getEmployeePendingRequests() {
		var criteria = this.newCriteria();
		var vacations = criteria
			.createAlias('status', 'status')
			.createAlias('deputy', 'deputy')
			.AND(
				criteria.restrictions.eq('status.name', 'Pending'),
				criteria.restrictions.eq('deputy.id', SESSION.user.id),
				criteria.restrictions.eq('isActive', true),
				criteria.restrictions.gt('fromDate', now())
			)
			.list();

		return vacations;
	}

	function getEmployeeCompletedRequests() {
		var criteria = this.newCriteria();
		var vacations = criteria
			.createAlias('status', 'status')
			.createAlias('deputy', 'deputy')
			.AND(
				criteria.restrictions.ne('status.name', 'Pending'),
				criteria.restrictions.eq('deputy.id', SESSION.user.id),
				criteria.restrictions.eq('isActive', true),
				criteria.restrictions.gt('fromDate', now())
			)
			.list();

		return vacations;
	}

	function getTeamLeadPendingRequests() {
		var criteria = this.newCriteria();

		var vacations = criteria
			.createAlias('status', 'status')
			.createAlias('user', 'user')
			.createAlias('deputy', 'deputy')
			.createAlias('user.team', 'team')
			.OR(
				criteria.restrictions.AND(
					criteria.restrictions.eq('status.name', 'Fill-in Approved'),
					criteria.restrictions.ne('user.id', SESSION.user.id),
					criteria.restrictions.eq('team.id', SESSION.user.team.id),
					criteria.restrictions.eq('isActive', true),
					criteria.restrictions.gt('fromDate', now())
				),
				criteria.restrictions.AND(
					criteria.restrictions.eq('status.name', 'Pending'),
					criteria.restrictions.eq('deputy.id', SESSION.user.id),
					criteria.restrictions.eq('isActive', true),
					criteria.restrictions.gt('fromDate', now())
				)
			)
			.list();

		return vacations;
	}

	function getManagerPendingRequests() {
		var criteria = this.newCriteria();
		var managerRequestsPending = criteria
			.createAlias('status', 's')
			.createAlias('deputy', 'd')
			.createAlias('user', 'u')
			.createAlias('u.role', 'r')
			.OR(
				criteria.restrictions.AND(
					criteria.restrictions.eq('s.name', 'Team Lead Approved'),
					criteria.restrictions.eq('isActive', true),
					criteria.restrictions.gt('fromDate', now())
				),
				criteria.restrictions.AND(
					criteria.restrictions.eq('s.name', 'Fill-in Approved'),
					criteria.restrictions.eq('r.name', 'team lead'),
					criteria.restrictions.eq('isActive', true),
					criteria.restrictions.gt('fromDate', now())
				),
				criteria.restrictions.AND(
					criteria.restrictions.eq('s.name', 'Fill-in Approved'),
					criteria.restrictions.ne('u.id', SESSION.user.id),
					criteria.restrictions.eq('r.name', 'manager'),
					criteria.restrictions.eq('isActive', true),
					criteria.restrictions.gt('fromDate', now())
				),
				criteria.restrictions.AND(
					criteria.restrictions.eq('s.name', 'Pending'),
					criteria.restrictions.eq('d.id', SESSION.user.id),
					criteria.restrictions.eq('isActive', true),
					criteria.restrictions.gt('fromDate', now())
				)
			)
			.list();

		return managerRequestsPending;
	}

	function getPendingRequests() { 
		var requests = [];

		if(SESSION.user.role == 'Employee') {
			requests = this.getEmployeePendingRequests();
		}

		else if(SESSION.user.role == 'Team Lead') {
			requests = this.getTeamLeadPendingRequests();
		}

		else if(SESSION.user.role == 'Manager') {
			requests = this.getManagerPendingRequests();
		}

		return requests;
	}	

	function getCompletedRequests(actions) {
		var actionIds = [];

		for(action in actions) {
			arrayAppend(actionIds, action.getObjectId());
		}
		
		if(arrayLen(actionIds) == 0) {
			return []
		}
		
		vacations = this.newCriteria()
			.in('id', actionIds)
			.list();

		return vacations;
	}

	private function getFirstDayOfWeek(date) {
		var theDate = ARGUMENTS.date;
		var isMonday = false;

		if(dayOfWeekAsString(dayOfWeek(theDate)) == 'Monday') {
			isMonday = true;
		}

		while(! isMonday){
			theDate = dateAdd("d", -1, theDate);

			if(dayOfWeekAsString(dayOfWeek(theDate)) == 'Monday') {
				isMonday = true;
			}
		}
		
		return theDate;
	}

	private function getLastDayOfWeek(date) {
		var theDate = date;

		if(dayOfWeekAsString(dayOfWeek(theDate)) == 'Monday') {
			return dateAdd('d', 4, theDate);
		}

		theDate = this.getFirstDayOfWeek(date);

		return dateAdd('d', 4, theDate);
	}
}