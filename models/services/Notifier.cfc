component output="false" displayname="Notifier" implements="models.services.INotifier" {

	property name="Vacation" inject="Vacation";
	property name="Mail" inject="services.Mailer";

	this.to = "mihail@13bik.com";
	this.from = "VacationNotifier@13bik.com";

	public function notifyWeekly() {
		// THIS IS FOR TESTING PURPOSES
		// var today = CreateDate(2016, 7, 1);

		var today = Now();
		var monday = DateAdd("d", 3, today);
		var sunday = DateAdd("d", 6, monday);
		var vacations = Vacation.newCriteria().between("fromDate", monday, sunday).list();
		var template = "weeklyNotification.cfm";
		if (ArrayLen(vacations)) {
			var subject = "Vacations Starting Next Week";
			Mail.sendMail(
				subject = subject,
				data = vacations,
				to = this.to,
				template = template,
				from = this.from
			);
		}
		
		exit;
	}

	public function notifySick(vacationId) {
		var vacation = Vacation.get(vacationId);
		var subject = "Sick Leave Notice";
		var template = "sickleave.cfm";
		Mail.sendMail(
			subject = subject,
			data = vacation,
			to = this.to,
			template = template,
			from = this.from
		);
	}
}
