<cfoutput>
	<table>
		<tr>
			<td>Type:</td>
			<td>#data['type']#</td>
		</tr>
		<tr>
			<td>Client:</td>
			<td>#CGI.local_addr#</td>
		</tr>
		<tr>
			<td>Browser:</td>
			<td>#CGI.http_user_agent#</td>
		</tr>
		<tr>
			<td>Message:</td>
			<td>#data['message']#</td>
		</tr>
		<tr>
			<td>Detail:</td>
			<td>#data['detail']#</td>
		</tr>
		<tr>
			<td colspan="2">
				<cfdump var="#data#" />
			</td>
		</tr>
	</table>
</cfoutput>