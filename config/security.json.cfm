[
    {
        "whitelist": "",
        "securelist": "teams\\.*,vacationStatuses\\.*,vacationTypes\\.*,Roles\\.*,users\\.delete,users\\.deleteUser",
        "match": "event",
        "roles": "Manager",
        "permissions": "IT",
        "redirect": "main.index",
        "useSSL": false
    },
	{
        "whitelist": "",
        "securelist": "dashboard\\.teamActions",
        "match": "event",
        "roles": "Team Lead",
        "permissions": "",
        "redirect": "main.index",
        "useSSL": false
    },
    {
        "whitelist": "",
        "securelist": "dashboard\\.usersActions",
        "match": "event",
        "roles": "Manager",
        "permissions": "",
        "redirect": "main.index",
        "useSSL": false
    },
    {
        "whitelist": "",
        "securelist": "^logs",
        "match": "event",
        "roles": "",
        "permissions": "IT",
        "redirect": "main.index",
        "useSSL": false
    },
    {
        "whitelist": "security\\.login,security\\.logout,security\\.resetPassword,notifier\\.index",
        "securelist": ".*",
        "match": "event",
        "roles": "",
        "permissions": "authenticatedUser",
        "redirect": "security.login",
        "useSSL": false
    }
]