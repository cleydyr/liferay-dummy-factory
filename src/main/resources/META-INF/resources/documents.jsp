<%@ include file="/init.jsp"%>

<div class="container-fluid-1280">
	<liferay-ui:success key="success" message="Documents created successfully" />
	<%@ include file="/command_select.jspf"%>

	<portlet:actionURL name="<%= LDFPortletKeys.DOCUMENTS %>" var="documentEditURL">
		<portlet:param name="<%= LDFPortletKeys.MODE %>" value="<%=LDFPortletKeys.MODE_DOCUMENTS %>" />
		<portlet:param name="redirect" value="<%=portletURL.toString()%>" />
	</portlet:actionURL>

	<aui:fieldset-group markupView="lexicon">	
		<aui:fieldset>
            <div class="entry-title form-group">
                <h1>Create Documents&nbsp;&nbsp;
                    <a aria-expanded="false" class="collapse-icon collapsed icon-question-sign" data-toggle="collapse" href="#navPillsCollapse0">
                    </a>
                </h1>
            </div>
        
            <div class="collapsed collapse" id="navPillsCollapse0" aria-expanded="false" >
                <blockquote class="blockquote-info">
                    <small>Example</small>
                    <p>if you enter the values <code>3</code> and <code>doc</code> the portlet will create three blank sites: <code>doc1</code>, <code>doc2</code>, and <code>doc3</code>.<p>
                </blockquote>
            
                <ul>
					<li>You must be signed in as an administrator in order to create documents<li>
                    <li>The counter always starts at <code>1</code></li>
					<li>If no site is selected, the default site will be <code>liferay.com</code><li>
                </ul>
            
                <h3>Creating Large Batches of documents</h3>
                <ul>
                    <li>If the number of documents is large (over <code>100</code>), go to <i>Control Panel -> Server Administration -> Log Levels -> Add Category</i>, and add <code>com.liferay.support.tools</code> and set to <code>INFO</code> to track progress (batches of 10%)</li>
                    <li>It may take some time (even for the logs to show) to create a large number of documents, and the page will hang until the process is complete; you can query the database if you are uncertain of the progress</li>
                </ul>
            </div>

			<%
			String numberOfDocumentsLabel= "Enter the number of documents you would like to create";
			String baseDocumentTitleLabel= "Enter the base document title (i.e. doc, newDoc, testDoc)";
			String baseDocumentDescriptionLabel = "Enter the base document description";
			String defaultOption = "(None)";
			String groupIdLabel = "Select a site to assign the documents to";
			List<Group> groups = GroupLocalServiceUtil.getGroups(QueryUtil.ALL_POS, QueryUtil.ALL_POS);
			%>

			<aui:form action="<%= documentEditURL %>" method="post" >
				<aui:input name="numberOfDocuments" label="<%= numberOfDocumentsLabel %>" >
					<aui:validator name="digits" />
					<aui:validator name="min">1</aui:validator>
					<aui:validator name="required" />				
				</aui:input>
				<aui:input name="baseDocumentTitle" label="<%= baseDocumentTitleLabel %>" cssClass="lfr-textarea-container" >
					<aui:validator name="required" />				
				</aui:input>
				<aui:input name="baseDocumentDescription" label="<%= baseDocumentDescriptionLabel %>" cssClass="lfr-textarea-container" type="textarea" wrap="soft">
					<aui:validator name="required" />				
				</aui:input>
				<aui:select name="groupId" label="<%= groupIdLabel %>"  >
					<aui:option label="<%= defaultOption %>" value="<%= themeDisplay.getScopeGroupId() %>" selected="<%= true %>" />
					<%
					for (Group group : groups) {
						if (group.isSite() && !group.getDescriptiveName().equals("Control Panel")) {
					%>
							<aui:option label="<%= group.getDescriptiveName() %>" value="<%= group.getGroupId() %>"/>
					<%
						}
					}
					%>
				</aui:select>		
					
				<aui:button-row>
					<aui:button type="submit" value="Run" cssClass="btn-lg btn-block btn-primary"/>
				</aui:button-row>	
			</aui:form>	
		</aui:fieldset>
	</aui:fieldset-group>
</div>
