package com.liferay.support.tools.portlet.actions;

import com.liferay.portal.kernel.log.Log;
import com.liferay.portal.kernel.log.LogFactoryUtil;
import com.liferay.portal.kernel.portlet.bridges.mvc.BaseMVCActionCommand;
import com.liferay.portal.kernel.portlet.bridges.mvc.MVCActionCommand;
import com.liferay.portal.kernel.servlet.SessionErrors;
import com.liferay.portal.kernel.servlet.SessionMessages;
import com.liferay.support.tools.common.DummyGenerator;
import com.liferay.support.tools.constants.LDFPortletKeys;
import com.liferay.support.tools.messageboard.MBContext;
import com.liferay.support.tools.messageboard.MBDummyFactory;

import javax.portlet.ActionRequest;
import javax.portlet.ActionResponse;
import javax.portlet.MutableRenderParameters;

import org.osgi.service.component.annotations.Component;
import org.osgi.service.component.annotations.Reference;

/**
 * Create Message Board
 * 
 * @author Yasuyuki Takeo
 */
@Component(
	immediate = true, 
	property = { 
		"javax.portlet.name=" + LDFPortletKeys.LIFERAY_DUMMY_FACTORY,
		"mvc.command.name=" + LDFPortletKeys.MB
	}, 
	service = MVCActionCommand.class
)
public class MBMVCActionCommand extends BaseMVCActionCommand {

	@Override
	protected void doProcessAction(ActionRequest request, ActionResponse response) throws Exception {

		try {
			MutableRenderParameters mutableRenderParameters = response.getRenderParameters();
			mutableRenderParameters.setValues("mvcRenderCommandName", LDFPortletKeys.COMMON);

			DummyGenerator<MBContext> dummyGenerator = _MBDummyFactory.create(request);
			dummyGenerator.create(request);

			SessionMessages.add(request, "success");

		} catch (Exception e) {
			hideDefaultSuccessMessage(request);
			SessionMessages.add(request, e.getClass());
			SessionErrors.add(request, e.getClass());
			MutableRenderParameters mutableRenderParameters = response.getRenderParameters();
			mutableRenderParameters.setValues(LDFPortletKeys.MODE, LDFPortletKeys.MODE_MB);
			mutableRenderParameters.setValues("mvcRenderCommandName", LDFPortletKeys.COMMON);
			_log.error(e, e);
			return;
		}

		MutableRenderParameters mutableRenderParameters = response.getRenderParameters();
		mutableRenderParameters.setValues("mvcRenderCommandName", LDFPortletKeys.COMMON);
		SessionMessages.add(request, "success");
	}

	@Reference
	MBDummyFactory _MBDummyFactory;
	
	private static final Log _log = LogFactoryUtil.getLog(MBMVCActionCommand.class);
}
