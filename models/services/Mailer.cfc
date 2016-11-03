component {
	this.templateBasePath = "/views/_templates/mails/";

	function sendMail(subject, data, to, from="admin@44km.com" template="default") {

		var mailBody = getMailBody(
			data = data,
			templateName = template,
			subject = subject
		);
		
		// writeOutput(mailBody); abort;

		mailService = new Mail(
			to = ARGUMENTS.to,
			from = ARGUMENTS.from,
			subject = ARGUMENTS.subject,
			body = mailBody,
			type = "html"
		);

		test = mailService.send();
		setNextEvent("Dashboard/index");
	}

	function sendErrorMail(exception) {
		this.sendMail(
			to = 'mihail@13bik.com',
			subject = 'Error on vacation.44km.com',
			data = ARGUMENTS.exception,
			from = "admin@44km.com",
			template = "error"
		);
	}

	private function getMailBody(templateName, data) {
		if(Right(templateName, 4) EQ ".cfm"){
			templateName = Left(templateName, Len(templateName) - 4);
		}

		savecontent variable="mailBody" {
			include this.templateBasePath & templateName & '.cfm'
		};
		
		return mailBody;
	}

	function mailingActions(data, subject) {
		switch(subject){
			case "To User":
				thisMail.data = data;
				thisMail.subject = "Vacation Approved By #data.approvedBy#";
				thisMail.to = data.getUser().getEmail();
				thisMail.template = "approve";

				sendMailToUser = false;

				// sick leave
				if (data.getType().getId() EQ 3 AND data.approvedBy EQ "Lead") {
					sendSickNotification = true;
				}
			break;

			case "Sick Leave":
				thisMail.data = data;
				thisMail.subject = "Sick Leave Notification";
				thisMail.to = data.sendTo;
				thisMail.template = "sickleave";

				sendSickNotification = false;
			break;

			case "Fill-in Request":
				thisMail.data = data;
				thisMail.subject = "Vacation Fill-in Request";
				thisMail.to = data.getDeputy().getEmail();
				thisMail.from = data.getUser().getEmail();
				thisMail.template = "request";
				thisMAil.data.sendTo = "fill-in";
			break;

			case "Fill-in Approved":
				thisMail.data = data;
				thisMail.subject = "Vacation Request";
				thisMail.to = data.sendTo.sendToApprove NEQ "" ? 
					data.sendTo.sendToApprove : data.getUser().getTeam().getLead().getEmail();
				thisMail.from = data.getUser().getEmail();
				thisMail.template = "request";
				thisMAil.data.sendTo = "lead";
				thisMAil.data.approvedBy = "Fill-in";

				sendMailToUser = true;
			break;

			case "Fill-in Rejected":
				thisMail.data = data;
				thisMail.subject = "Vacation Request has been denied";
				thisMail.to = data.getUser().getEmail();
				thisMail.from = data.getDeputy().getEmail();
				thisMail.template = "reject";

				thisMail.data.rejectedBy = LCase(ListFirst(subject, ' '));
			break;

			case "Team Lead Approved":
			case "Manager Approved":
				thisMail.data = data;
				thisMail.subject = "New Vacation Added";
				thisMail.to = data.sendTo.sendToNotify;
				thisMail.from = data.getUser().getEmail();
				thisMail.template = "request";
				thisMail.data.sendTo = "manager";
				
				sendMailToUser = true;
			break;

			case "Team Lead Rejected":
				thisMail.data = data;
				thisMail.subject = "Vacation Request has been rejected";
				thisMail.to = data.getUser().getEmail();
				thisMail.from = data.getUser().getTeam().getLead().getEmail();
				thisMail.template = "reject";

				thisMail.data.rejectedBy = LCase(ListFirst(subject, ' '));
			break;

			case "Manager Rejected":
				thisMail.data = data;
				thisMail.subject = "Vacation Request has been rejected";
				thisMail.to = data.getUser().getEmail();
				thisMail.from = data.sendFromEmail;
				thisMail.template = "reject";

				thisMail.data.manager = data.sendFromFirstName & ' ' & data.sendFromLastName;

				thisMail.data.rejectedBy = LCase(ListFirst(subject, ' '));
			break;
		
			default:
			break;
		}
		
		sendMail(argumentCollection = thisMail);

		if (IsDefined("sendMailToUser") AND sendMailToUser) {
			mailingActions(data, "To User", data.getUser().getEmail());
		}

		if (IsDefined("sendSickNotification") AND sendSickNotification) {
			// mailingActions(data, "Sick Leave", "230@44km.com,250@44km.com,260@44km.com");
			mailingActions(data, "Sick Leave", "latinka@13bik.com");
		}
	}
}